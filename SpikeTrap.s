;this file for FamiTone2 libary generated by FamiStudio

_SpikeTrap:
	.word @ntsc
	.word @ntsc
@ntsc:
	.word @sfx_ntsc_megamanhit
	.word @sfx_ntsc_mushroom

@sfx_ntsc_megamanhit:
	.byte $8a,$0a,$89,$3f,$01,$8a,$0b,$01,$89,$f0,$02,$8a,$09,$89,$37,$01
	.byte $8a,$08,$89,$3f,$01,$8a,$07,$01,$8a,$06,$01,$8a,$05,$01,$8a,$04
	.byte $01,$8a,$03,$01,$8a,$02,$01,$8a,$01,$01,$8a,$00,$01,$8a,$0f,$01
	.byte $00
@sfx_ntsc_mushroom:
	.byte $85,$00,$84,$d5,$83,$7d,$89,$f0,$02,$85,$01,$84,$1c,$02,$85,$00
	.byte $84,$d5,$02,$84,$a9,$02,$84,$8e,$02,$84,$6a,$02,$84,$8e,$02,$85
	.byte $01,$84,$0c,$02,$85,$00,$84,$d5,$02,$84,$b3,$02,$84,$86,$02,$84
	.byte $b3,$02,$84,$86,$02,$84,$6a,$02,$84,$59,$02,$84,$42,$02,$84,$59
	.byte $02,$84,$ef,$02,$84,$bd,$02,$84,$9f,$02,$84,$77,$02,$84,$9f,$02
	.byte $84,$77,$02,$84,$5e,$02,$84,$4f,$02,$84,$3b,$02,$84,$4f,$01,$00

.export _SpikeTrap
