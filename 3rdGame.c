
/*
Credit: Base Code is from Offscreen Scrolling Example
This is essentially a heavily modded version of
Offscreen Scrolling from the examples.
*/

#include "neslib.h"
#include <string.h>

// 0 = horizontal mirroring
// 1 = vertical mirroring
#define NES_MIRRORING 1

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

DEF_METASPRITE_2x2(player_sprite, 0xd8, 0); // $05

// number of rows in scrolling playfield (without status bar)
#define PLAYROWS 24

// buffers that hold vertical slices of nametable data
char ntbuf1[PLAYROWS];	// left side
char ntbuf2[PLAYROWS];	// right side

// a vertical slice of attribute table entries
char attrbuf[PLAYROWS/4];

/// FUNCTIONS

// convert from nametable address to attribute table address
word nt2attraddr(word a) {
  return (a & 0x2c00) | 0x3c0 |
    ((a >> 4) & 0x38) | ((a >> 2) & 0x07);
}

// generate new random segment
void new_segment() {
  seg_height = 2;
  seg_width = (rand8() & 3) + 1;
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
  // Establish Player
  struct Actor player;
  player.x = 75;
  player.y = 1;
  player.dx = 0;
  player.dy = 2; // Player will 'fall' onto the floor.
  player.is_alive = true;
  
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
      player.y -= 45;
      jump_lock = true;
    }
    // Account for gravity
    if(player.y > 173){ // On the floor...
      player.dy = 0;
      jump_lock = false; // Allow for jumping
    }
    if(player.y < 173){ // In the air...
      player.dy = 2;
    }
    // Render player_sprite
    if(player.is_alive){
      player.x += player.dx;
      player.y += player.dy;
      oam_id = oam_meta_spr(player.x, player.y, oam_id, player_sprite);
    }
  }
}

/*{pal:"nes",layout:"nes"}*/
const char PALETTE[32] = { 
  0x00,			// background color

  0x3F,0x37,0x30,0x00,	
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

  // 'Active-game' Screen
  active_game_screen();
}
