;this file for FamiTone2 libary generated by FamiStudio


.if FAMISTUDIO_CFG_C_BINDINGS
.export _sounds=sounds
.endif

sounds:
	.word @ntsc
	.word @ntsc
@ntsc:
	.word @sfx_ntsc_megamanhit
	.word @sfx_ntsc_mushroom

@sfx_ntsc_megamanhit:
	.byte $85,$04,$84,$b3,$83,$ff,$89,$f0,$01,$84,$f3,$01,$85,$05,$84,$32
	.byte $01,$83,$f0,$01,$85,$01,$84,$07,$83,$f8,$01,$84,$2d,$01,$84,$53
	.byte $01,$84,$79,$01,$84,$9f,$01,$84,$c5,$01,$84,$eb,$01,$85,$02,$84
	.byte $11,$01,$84,$37,$01,$84,$5c,$02,$00
@sfx_ntsc_mushroom:
	.byte $85,$00,$84,$d5,$83,$7d,$89,$f0,$02,$85,$01,$84,$1c,$02,$85,$00
	.byte $84,$d5,$02,$84,$a9,$02,$84,$8e,$02,$84,$6a,$02,$84,$8e,$02,$85
	.byte $01,$84,$0c,$02,$85,$00,$84,$d5,$02,$84,$b3,$02,$84,$86,$02,$84
	.byte $b3,$02,$84,$86,$02,$84,$6a,$02,$84,$59,$02,$84,$42,$02,$84,$59
	.byte $02,$84,$ef,$02,$84,$bd,$02,$84,$9f,$02,$84,$77,$02,$84,$9f,$02
	.byte $84,$77,$02,$84,$5e,$02,$84,$4f,$02,$84,$3b,$02,$84,$4f,$01,$00

.export sounds
