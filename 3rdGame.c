

/*
Credit: Base Code is from Offscreen Scrolling Example
This is essentially a heavily modded version of
Offscreen Scrolling from the examples.
*/
#include <stdio.h>
#include <stdlib.h>
#include "neslib.h"
#include <string.h>

//#link "infiniteBackground.s"


// 0 = horizontal mirroring
// 1 = vertical mirroring
#define NES_MIRRORING 1

// Music Code
void __fastcall__ famitone_update(void);
//#link "famitone2.s"
//#link "RunnerTheme.s"
extern char RunnerTheme[];
//#link "PauseBeep.s"
extern char PauseBeep[];
//#link "BulletTrap.s"
extern char BulletTrap[];
//#link "SpikeTrap.s"
//#link "infiniteTitle.s"
extern char SpikeTrap[];

extern const byte infiniteTitle_pal[16];
extern const byte infiniteTitle_rle[];
extern const byte infiniteBackground_pal[16];
extern const byte infiniteBackground_rle[];

// VRAM update buffer
#include "vrambuf.h"
//#link "vrambuf.c"

// link the pattern table into CHR ROM
//#link "chr_generic.s"

/// GLOBAL VARIABLES
word x_scroll;		// X scroll amount in pixels
byte seg_height;	// segment height in metatiles
byte seg_width;		// segment width in metatiles
byte seg_char;		// character to draw
byte seg_palette;	// attribute table value
bool jump_lock; 	// prevents player from jumping infinitely

struct Actor{
  byte x; // Current x-location
  byte y; // Current y-location
  sbyte dx; // Delta-x
  sbyte dy; // Delta-y
  bool is_alive; // Is the actor supposed to be 'alive' right now?
};

// Metasprite Stuff
// define a 2x2 metasprite
#define DEF_METASPRITE_2x2(name,code,pal)\
const unsigned char name[]={\
        0,      0,      (code)+0,   pal, \
        0,      8,      (code)+1,   pal, \
        8,      0,      (code)+2,   pal, \
        8,      8,      (code)+3,   pal, \
        128};

DEF_METASPRITE_2x2(player_sprite, 0xd8, 0); // $05 (Stand)
DEF_METASPRITE_2x2(playerRRun1, 0xdc, 0);
DEF_METASPRITE_2x2(playerRRun2, 0xe0, 0);
DEF_METASPRITE_2x2(playerRRun3, 0xe4, 0);
DEF_METASPRITE_2x2(playerRJump, 0xe8, 0);

DEF_METASPRITE_2x2(spike_sprite, 0xd4, 0);
DEF_METASPRITE_2x2(bullet_sprite, 0xf8, 0);

const unsigned char* const playerRunSeq[9] = {
  playerRRun1, playerRRun2, playerRRun3, 
  playerRRun1, playerRRun2, playerRRun3, 
  playerRRun1, playerRRun2,
};

// number of rows in scrolling playfield (without status bar)
#define PLAYROWS 24

// buffers that hold vertical slices of nametable data
char ntbuf1[PLAYROWS];	// left side
char ntbuf2[PLAYROWS];	// right side

// a vertical slice of attribute table entries
char attrbuf[PLAYROWS/4];

// score (BCD)
// static byte score = 0;

/// FUNCTIONS

// convert from nametable address to attribute table address
word nt2attraddr(word a) {
  return (a & 0x2c00) | 0x3c0 |
    ((a >> 4) & 0x38) | ((a >> 2) & 0x07);
}


void new_segment() {
  seg_height = 2;
  seg_width = 4;
  seg_palette = 3;
  seg_char = 0xf4;
}

// draw metatile into nametable buffers
// y is the metatile coordinate (row * 2)
// ch is the starting tile index in the pattern table
void set_metatile(byte y, byte ch) {
  ntbuf1[y*2] = ch;
  ntbuf1[y*2+1] = ch+1;
  ntbuf2[y*2] = ch+2;
  ntbuf2[y*2+1] = ch+3;
}

// set attribute table entry in attrbuf
// x and y are metatile coordinates
// pal is the index to set
void set_attr_entry(byte x, byte y, byte pal) {
  if (y&1) pal <<= 4;
  if (x&1) pal <<= 2;
  attrbuf[y/2] |= pal;
}

// fill ntbuf with tile data
// x = metatile coordinate
void fill_buffer(byte x) {
  byte i,y;
  // clear nametable buffers
  memset(ntbuf1, 0, sizeof(ntbuf1));
  memset(ntbuf2, 0, sizeof(ntbuf2));
  // draw segment slice to both nametable buffers
  for (i=0; i<seg_height; i++) {
    y = PLAYROWS/2-1-i;
    set_metatile(y, seg_char);
    set_attr_entry(x, y, seg_palette);
  }
}

// write attribute table buffer to vram buffer
void put_attr_entries(word addr) {
  byte i;
  for (i=0; i<PLAYROWS/4; i++) {
    VRAMBUF_PUT(addr, attrbuf[i], 0);
    addr += 8;
  }
  vrambuf_end();
}

// update the nametable offscreen
// called every 8 horizontal pixels
void update_offscreen() {
  register word addr;
  byte x;
  // divide x_scroll by 8
  // to get nametable X position
  x = (x_scroll/8 + 32) & 63;
  // fill the ntbuf arrays with tiles
  fill_buffer(x/2);
  // get address in either nametable A or B
  if (x < 32)
    addr = NTADR_A(x, 4);
  else
    addr = NTADR_B(x&31, 4);

  vrambuf_put(addr | VRAMBUF_VERT, ntbuf1, PLAYROWS);
  vrambuf_put((addr+1) | VRAMBUF_VERT, ntbuf2, PLAYROWS);
  put_attr_entries(nt2attraddr(addr));
  // every 4 columns, clear attribute table buffer
  if ((x & 3) == 2) {
    memset(attrbuf, 0, sizeof(attrbuf));
  }
  // decrement segment width, create new segment when it hits zero
  if (--seg_width == 0) {
    new_segment();
  }
}

// scrolls the screen left one pixel
void scroll_left() {
  // update nametable every 16 pixels
  if ((x_scroll & 15) == 0) {
    update_offscreen();
  }
  // increment x_scroll
  x_scroll += 2;
}

// Active-game State/Screen
void active_game_screen() {
  // Control number of spikes and bullets
  byte i;
  byte max_spikes;
  byte current_spikes;
  
  // Establish Actors
  struct Actor player;
  struct Actor spikes[5]; // Max number supported is 5.
  struct Actor Bullet; 
  
  // Establish number of spikes and bullets to use
  max_spikes = 3;
  current_spikes = 0;
  
  // Prepare player
  player.x = 150;
  player.y = 1;
  player.dx = 0;
  player.dy = 1;  // Player will 'fall' onto the floor.
  player.is_alive = true;
  
  // Prepare Bullet
  Bullet.is_alive = false;
  
  // get data for initial segment
  new_segment();
  x_scroll = 0;
  // infinite loop
  while (1) {
    char pad = pad_poll(0);
    char oam_id = 0;
    
    // ensure VRAM buffer is cleared
    ppu_wait_nmi();
    vrambuf_clear();
    // split at sprite zero and set X scroll
    split(x_scroll, 0);
    // scroll to the left
    scroll_left();
    
    // Despawning Rules for Spikes
    if(current_spikes > 0){ // At least 1 spike has to be active.
      for(i = 0; i < max_spikes; i++){
        if(spikes[i].is_alive && spikes[i].x < 5){
          spikes[i].is_alive = false;
          current_spikes--;
          oam_clear();
        }
      }
    }
    
    // Spawning Rules for Spikes
    if(current_spikes < max_spikes){ // If we're allowed to spawn another spike...
      if(rand8() % 20 == 0){ // 5% spawn rate per frame; Activate a spike on success.
        for(i = 0; i < max_spikes; i++){ // Check for a free space among the spikes
          if(!spikes[i].is_alive){ // Take the first space found
            spikes[i].x = 240;
            spikes[i].y = 175;
            spikes[i].dx = -2;
            spikes[i].is_alive = true;
            current_spikes++; // Increment current number of spikes
            break;
          }
        }
      }
    }
    
    // Spawning Rules for Bullet
    if(!Bullet.is_alive){ // If bullet is not active...
      if(rand8() % 50 == 0){
        sfx_init(BulletTrap);
        sfx_play(0,0);
        Bullet.x = 240;
        Bullet.y = 150;
        Bullet.dx = -3;
        Bullet.is_alive = true;
      }
    }
    
    // Despawning Rule for Bullet
    if(Bullet.is_alive && Bullet.x < 5){
      Bullet.is_alive = false;
      oam_clear();
    }
    
    // Player Controls
    // Sub: D-pad Movement
    if(pad & PAD_LEFT && player.x > 10){
      if(pad & PAD_B){ //Spriting
        player.dx = -3;
      }
      else{ // Walking
        player.dx = -2;
      }
    }
    else if(pad & PAD_RIGHT && player.x < 230){
      if(pad & PAD_B){ //Sprinting
        player.dx = 3;
      }
      else{ // Walking
        player.dx = 2;
      }
    }
    else{ // 'Standing'
      player.dx = 0;
    }
    // Sub: Jumping
    if(pad & PAD_A && !jump_lock){
      player.y -= 5;
      player.dy = -8;
      jump_lock = true;
    }
    // Account for gravity
    if(player.y > 173){ // Landing on the floor...
      player.dy = 0;
      jump_lock = false; // Allow for jumping
    }
    if(player.y < 173 && player.dy < 3){ // In the air...; with a terminal velocity
      if(!jump_lock){
        player.dy = 2;
      }
      else{
        player.dy += 1;
      }
    }
    
    // Render active spikes
    for(i = 0; i < max_spikes; i++){
      if(spikes[i].is_alive){
        spikes[i].x += spikes[i].dx;
      	oam_id = oam_meta_spr(spikes[i].x, spikes[i].y, oam_id, spike_sprite);
      }
    }
    
    // Render active bullet
    if(Bullet.is_alive){
      Bullet.x += Bullet.dx;
      oam_id = oam_meta_spr(Bullet.x, Bullet.y, oam_id, bullet_sprite);
    }
    
    // Render player_sprite
    player.x += player.dx;
    player.y += player.dy;
    oam_id = oam_meta_spr(player.x, player.y, oam_id, player_sprite);
    
    // player_sprite (Stand)
    
    // byte counter = 0;
    // playerRunSeq[counter]
    /*counter++;
    if(counter = 10){
    	counter = 0;
    }*/
    // oam_clear();
    
    // Check for player collision with...
    // Sub: Spikes
    for(i = 0; i < max_spikes; i++){
      if(spikes[i].is_alive){
        if(abs(spikes[i].x - player.x) < 9 && abs(spikes[i].y - player.y) < 9){
          player.is_alive = false; // Player dies
          music_stop();
          sfx_init(SpikeTrap);
          sfx_play(0,0);
        }
      }
    }
    // Sub: Bullet
    if(Bullet.is_alive){
      if(abs(Bullet.x - player.x) < 11 && abs(Bullet.y - player.y) < 13){
        player.is_alive = false; // Player dies
        music_stop();
        sfx_init(SpikeTrap);
        sfx_play(0,0);
      }
    }

    // If the player dies, exit the active-game screen.
    if(!player.is_alive){
      delay(28);
      break;
    }
  }
}

// Effect for transitioning between screens
void fade_in() {
  byte vb;
  for (vb=0; vb<=4; vb++) {
    // set virtual bright value
    pal_bright(vb);
    // wait for 4/60 sec
    ppu_wait_frame();
    ppu_wait_frame();
    ppu_wait_frame();
    ppu_wait_frame();
  }
}

// Function for displaying Menu or Background
void show_screen(const byte* pal, const byte* rle) {
  // disable rendering
  ppu_off();
  // set palette, virtual bright to 0 (total black)
  pal_bg(pal);
  pal_bright(0);
  // unpack nametable into the VRAM
  vram_adr(0x2000);
  vram_unrle(rle);
  // enable rendering
  ppu_on_all();
  fade_in();
}

// draw the scoreboard, right now just two digits
/*void draw_scoreboard() {
  oam_off = oam_spr(24+0, 24, '0'+(score >> 4), 2, oam_off);
  oam_off = oam_spr(24+8, 24, '0'+(score & 0xf), 2, oam_off);
}*/

/*{pal:"nes",layout:"nes"}*/
const char PALETTE[32] = { 
  0x04,			// background color

  0x15,0x37,0x30,0x00,	
  0x1C,0x20,0x2C,0x00,	
  0x00,0x10,0x20,0x00,
  0x06,0x16,0x26,0x00,

  0x06,0x37,0x0F,0x00,	// enemy sprites
  0x00,0x37,0x25,0x00,	
  0x0D,0x2D,0x1A,0x00,
  0x0D,0x27,0x2A	// player sprites
};

void setup_graphics(){
  // set palette colors
  pal_all(PALETTE);
  
  // set attributes
  vram_adr(0x23c0);
  vram_fill(0x55, 8);
  
  // set sprite 0
  oam_clear();
  oam_spr(1, 30, 0xa0, 0, 0);
  
  // clear vram buffer
  vrambuf_clear();
  set_vram_update(updbuf);
  
  // enable PPU rendering (turn on screen)
  ppu_on_all();
}
  
// main function, run after console reset
void main(void) {
  setup_graphics();
  
  // Note: Intro-Screen Goes Here

  // Initialize Music
  famitone_init(RunnerTheme);
  nmi_set_callback(famitone_update);
  music_play(0);
  
  // Pre-Check with Enter
  // music_stop();
  
  // Start with Main Menu
 show_screen(infiniteTitle_pal, infiniteTitle_rle); 
  while(1){
    char pad = pad_poll(0);
  	if(pad & PAD_START){
          
          break;
        }
  }
  
  // Swap to Background
  show_screen(infiniteBackground_pal, infiniteBackground_rle);
  
  /*byte runseq = actor_x[i] & 7;
  if (actor_dx[i] >= 0)
    runseq += 8;*/
  
  // 'Active-game' Screen
  active_game_screen();
  
  // draw scoreboard
  // draw_scoreboard();
   
  // Note: Game-Over Screen Goes here
  while(1){}; // Placeholder
}
