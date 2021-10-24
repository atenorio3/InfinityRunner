;this file for FamiTone2 library generated by FamiStudio

.if FAMISTUDIO_CFG_C_BINDINGS
.export _danger_streets_music_data=danger_streets_music_data
.endif

danger_streets_music_data:
	.byte 1
	.word @instruments
	.word @samples-75
	.word @song0ch0,@song0ch1,@song0ch2,@song0ch3,@song0ch4,307,256

.export danger_streets_music_data
.global FAMISTUDIO_DPCM_PTR

@instruments:
	.byte $70 ;instrument 00 (key037)
	.word @env8, @env6, @env1
	.byte $00
	.byte $70 ;instrument 01 (key037p)
	.word @env0, @env6, @env5
	.byte $00
	.byte $70 ;instrument 02 (key037p1)
	.word @env9, @env6, @env5
	.byte $00
	.byte $70 ;instrument 03 (key037q)
	.word @env11, @env6, @env1
	.byte $00
	.byte $70 ;instrument 04 (key038)
	.word @env8, @env10, @env1
	.byte $00
	.byte $70 ;instrument 05 (key047)
	.word @env8, @env4, @env1
	.byte $00
	.byte $70 ;instrument 06 (key047p)
	.word @env0, @env4, @env5
	.byte $00
	.byte $70 ;instrument 07 (key047q)
	.word @env11, @env4, @env1
	.byte $00
	.byte $b0 ;instrument 08 (key1)
	.word @env7, @env1, @env1
	.byte $00
	.byte $70 ;instrument 09 (solo1)
	.word @env12, @env1, @env2
	.byte $00
	.byte $70 ;instrument 0a (solo1q)
	.word @env3, @env1, @env2
	.byte $00
	.byte $30 ;instrument 0b (solo2)
	.word @env12, @env1, @env2
	.byte $00
	.byte $30 ;instrument 0c (solo2q)
	.word @env3, @env1, @env2
	.byte $00

@samples:
@env0:
	.byte $c3,$c3,$c2,$05,$c1,$05,$c0,$00,$06
@env1:
	.byte $c0,$7f,$00,$00
@env2:
	.byte $c0,$0f,$c1,$02,$c2,$02,$c1,$02,$c0,$c0,$c0,$00,$02
@env3:
	.byte $c4,$02,$c3,$0c,$c2,$0b,$c1,$12,$c0,$00,$08
@env4:
	.byte $c0,$c0,$c4,$c4,$c7,$c7,$00,$00
@env5:
	.byte $c4,$7f,$00,$00
@env6:
	.byte $c0,$c0,$c3,$c3,$c7,$c7,$00,$00
@env7:
	.byte $c6,$c6,$c7,$c7,$c6,$c6,$c5,$c5,$c4,$c4,$c3,$03,$c2,$05,$c1,$05,$c0,$00,$10
@env8:
	.byte $c7,$c7,$c6,$c5,$c5,$c4,$c4,$c3,$02,$c2,$02,$c1,$02,$c0,$00,$0d
@env9:
	.byte $c3,$c3,$c2,$c2,$c1,$04,$c0,$00,$06
@env10:
	.byte $c0,$c0,$c3,$c3,$c8,$c8,$00,$00
@env11:
	.byte $c3,$c3,$c2,$03,$c1,$06,$c0,$00,$06
@env12:
	.byte $cc,$cb,$ca,$ca,$c9,$03,$c8,$03,$c7,$07,$c6,$08,$c5,$0a,$c4,$0c,$c3,$0c,$c2,$12,$c1,$19,$c0,$00,$16
@song0ch0:
	.byte $fb, $03
@song0ch0loop:
@song0ref4:
	.byte $87, $80, $2c, $85, $2d, $2c, $85
@song0ref11:
	.byte $2c, $89, $2c, $85, $2d, $2c, $89, $86, $2c, $85, $80, $2c, $85, $2d, $2c, $85, $2c, $89, $8a, $32, $85, $37, $36, $85
	.byte $8e, $36, $81
	.byte $ff, $16
	.word @song0ref4
	.byte $8a, $33, $32, $85, $8e, $33, $8a, $36, $85
	.byte $ff, $1d
	.word @song0ref4
	.byte $ff, $18
	.word @song0ref4
	.byte $36, $85, $8e, $36, $85
@song0ref61:
	.byte $87, $80, $2c, $85, $2d, $2c, $85, $2d, $94, $30, $85, $80, $2d, $94, $33
@song0ref76:
	.byte $80, $2d, $2d, $94, $28, $85, $2c, $85, $80, $2d, $94, $2d, $80, $2d, $2d, $94, $2d, $80, $2c, $89, $8a, $33, $94, $2d
	.byte $8a, $37, $37, $94, $22, $85, $87, $80, $2d, $94, $1f, $80, $2d, $2c, $85, $2d, $94, $1e, $20, $23, $80, $2d, $94, $23
	.byte $80, $2d, $2d, $94, $22, $8d, $80, $2c, $85, $2d, $2c, $85, $2c, $89, $8a, $32, $85, $37, $36, $89
	.byte $ff, $22
	.word @song0ref61
	.byte $2d, $94, $1f, $80, $2c, $89, $2d, $94, $23
	.byte $ff, $0d
	.word @song0ref76
@song0ref159:
	.byte $8a, $32, $85, $37, $36, $89, $87
@song0ref166:
	.byte $24, $85, $25, $25, $98, $33, $8a, $25, $98, $34, $36, $83, $8a, $25, $98, $37, $8a, $25, $25, $98, $28, $85, $2a, $2c
	.byte $83, $8a, $25, $98, $2d, $8a, $25, $24, $85, $24, $89, $29, $94, $33, $80, $2d, $2d, $94, $30, $85, $2c, $85, $8a
	.byte $ff, $1a
	.word @song0ref166
@song0ref216:
	.byte $94, $3b, $80, $2d, $2d, $94, $40, $85, $4e, $85, $8a, $29, $94, $4f, $8a, $29, $28, $85, $29, $94, $48, $85, $8a, $29
	.byte $94, $49, $8a, $29, $29, $94, $44, $85, $46, $48, $83, $8a, $29, $94, $49, $8a, $29, $28, $85, $29, $98, $46, $48, $83
	.byte $80, $2d, $98, $4b, $8a, $33, $33, $98, $44, $85, $48, $85, $8a, $29, $98, $49, $8a, $29, $28, $85, $29, $98, $4a, $85
	.byte $8a, $29, $98, $4b, $8a, $29, $29, $98, $4e, $83, $4c, $4a, $85, $8a, $29, $98, $4b, $8a, $29, $28, $85, $29, $94, $48
	.byte $85, $80, $2d, $94, $4b, $8a, $33, $33, $94, $40, $85, $44, $85, $80, $2d, $94, $45, $80, $2d, $2d, $94, $45, $80
	.byte $ff, $0f
	.word @song0ref11
	.byte $85, $86, $2d, $8a, $32, $85, $37, $36, $85, $8e, $36, $81
	.byte $ff, $16
	.word @song0ref4
	.byte $8a, $33, $32, $85, $8e, $33, $8a, $36, $85
	.byte $ff, $1d
	.word @song0ref4
	.byte $ff, $18
	.word @song0ref4
	.byte $36, $85, $8e, $36, $85
@song0ref373:
	.byte $8a, $24, $85, $25, $94, $2d, $8a, $25, $25, $94, $2d, $8a, $25, $24, $85, $25, $94, $31, $8a, $25, $25, $94, $32, $85
	.byte $8a, $25, $94, $2d, $8a, $25, $94, $2d, $8a, $25, $24, $85, $25, $80, $2c, $85, $2d, $94, $49, $80, $2d, $2d, $94, $4a
	.byte $85, $8a, $25, $94, $45, $8a, $25, $94, $45, $8a, $25, $24, $85, $25, $24, $85, $25, $94, $4f, $8a, $25, $25, $94, $44
	.byte $85, $8a, $25, $94, $49, $8a, $25, $94, $49, $8a, $25, $24, $85, $25, $80, $2c, $85, $2d, $94, $41, $80, $2d, $2d, $94
	.byte $48, $85, $8a, $29, $94, $4f, $8a, $29, $94, $4f, $8a, $29, $28, $85, $29, $28, $85, $29, $94, $4f, $8a, $29, $29, $94
	.byte $44, $85, $8a, $29, $94, $4b, $8a, $29, $94, $4b, $8a, $29, $28, $85, $29, $88, $30, $85, $31, $98, $49, $88, $31, $31
	.byte $98, $40, $85, $8a, $29, $98, $49, $8a, $29, $98, $49, $8a, $29, $28, $85, $29, $28, $85, $29, $94, $33, $8a, $29, $29
	.byte $94, $36, $85, $8a, $29, $94, $31, $8a, $29, $94, $31, $8a, $29, $29, $98, $37, $8a, $29, $88, $31, $98, $31, $88, $31
	.byte $98, $31, $88, $31, $31, $98, $29, $1e, $81
	.byte $ff, $2b
	.word @song0ref373
@song0ref577:
	.byte $94, $37, $8a, $25, $25, $94, $2c, $85, $8a, $25, $94, $31, $8a, $25, $94, $31, $8a, $25, $24, $85, $25, $80, $2c, $85
	.byte $2d, $98, $31, $80, $2d, $98, $33, $94, $49, $98, $36, $81, $80, $23, $98, $3b, $80, $23, $98, $3b, $80, $23, $23, $98
	.byte $41, $80, $23, $23, $98, $41, $80, $22, $85, $23, $23, $98, $44, $85, $8a, $29, $98, $49, $8a, $29, $98, $49, $8a, $29
	.byte $28, $85, $29, $28, $85, $29, $94, $49, $8a, $29, $29, $94, $3a, $85, $80, $2d, $94, $45, $80, $2d, $94, $45, $80, $2d
	.byte $2d, $94, $45, $80, $2d, $2c, $85, $2c, $85, $2d, $2c, $85, $2d, $2c, $85, $2c, $85, $2d, $2c, $89, $2c, $8d, $86, $2c
	.byte $8d
@song0ref698:
	.byte $8f, $2c, $85, $2c, $85, $2d, $2c, $85, $2c, $8d, $94, $16, $18, $87, $10, $95, $86, $2d, $94, $0b, $86, $2d, $94, $0b
	.byte $86, $2d, $2d, $94, $0a, $85, $87, $06, $85, $86, $2d, $94, $07, $86, $2c, $85, $2d, $2d, $94, $0b, $86, $2c, $d1
	.byte $ff, $18
	.word @song0ref698
	.byte $12, $14, $83, $86, $2d, $94, $15, $86, $2d, $94, $15, $86, $2d, $2d, $94, $15, $86, $2c, $b1, $1f, $1f, $37, $1f, $23
	.byte $23, $3b, $22, $81, $8f, $2c, $85, $2c, $85, $2d, $2c, $85, $2c, $8d, $98, $2e, $30, $87, $28, $95, $86, $2d, $98, $23
	.byte $86, $2d, $98, $23, $86, $2d, $2d, $98, $22, $85, $87, $1e, $85, $86, $2c, $85, $2c, $85, $2d, $2d, $98, $29, $86, $2c
	.byte $99, $90, $12, $14, $83, $1a, $85, $1e, $85, $26, $28, $83, $22, $85, $1e, $85, $1a, $85, $87, $98, $30, $32, $83, $86
	.byte $2d, $98, $33, $86, $2d, $98, $33, $86, $2d, $2d, $98, $33, $86, $2c, $89, $98, $34, $36, $83, $3a, $95, $40, $85, $86
	.byte $2d, $98, $41, $86, $2d, $98, $41, $86, $2d, $2d, $98, $40, $85, $87, $40, $42, $45, $86, $2d, $98, $45, $86, $2d, $98
	.byte $45, $86, $2d, $2d, $98, $45, $86, $2d, $98, $3e, $40, $83, $44, $a5, $14, $9d
	.byte $ff, $3a
	.word @song0ref61
	.byte $ff, $22
	.word @song0ref61
	.byte $2d, $94, $1f, $80, $2c, $89, $2d, $94, $23
	.byte $ff, $0d
	.word @song0ref76
	.byte $ff, $27
	.word @song0ref159
	.byte $8a
	.byte $ff, $1a
	.word @song0ref166
	.byte $ff, $49
	.word @song0ref216
	.byte $8d, $86, $2d, $94, $45, $86, $2d, $94, $45, $86, $2d, $2c, $85, $2c, $b1, $2c, $85, $2c, $85, $2d, $2c, $89, $8f, $2c
	.byte $85, $2c, $85, $2d, $2c, $85, $2c, $b1, $82, $2d, $2d, $2d, $2d, $80, $2d, $2d, $2d, $2c, $81
	.byte $ff, $81
	.word @song0ref373
	.byte $ff, $2b
	.word @song0ref373
	.byte $ff, $51
	.word @song0ref577
	.byte $fd
	.word @song0ch0loop
@song0ch1:
@song0ch1loop:
@song0ref992:
	.byte $87, $82, $2c, $85, $2d, $2c, $85, $2c, $89, $2c, $85, $2d, $2c, $91, $2c, $85, $2d, $2c, $85, $2c, $89, $8c, $32, $85
	.byte $37, $36, $89
	.byte $ff, $14
	.word @song0ref992
	.byte $8c, $33, $32, $89, $36, $85
	.byte $ff, $19
	.word @song0ref992
	.byte $ff, $16
	.word @song0ref992
	.byte $36, $8d
@song0ref1036:
	.byte $97, $92
@song0ref1038:
	.byte $30, $83, $94, $30, $92, $30, $32, $83, $30, $85, $28, $85, $2c, $a5, $28, $2c, $83, $28, $85, $22, $8d, $1e, $95, $1e
	.byte $20, $22, $e1, $97
	.byte $ff, $14
	.word @song0ref1038
@song0ref1069:
	.byte $9d, $1e, $22, $87, $28, $89, $2c, $c5
@song0ref1077:
	.byte $8f, $96, $32, $85, $34, $36, $8b, $32, $85, $28, $85, $2a, $2c, $a3, $92, $30, $32, $87, $30, $89, $2c, $85
	.byte $ff, $0d
	.word @song0ref1077
@song0ref1102:
	.byte $92, $36, $3a, $87, $40, $89, $4e, $85, $97, $48, $95, $44, $85, $46, $48, $9b, $96, $46, $48, $83, $4a, $85, $48, $85
	.byte $44, $85, $48, $85, $97, $4a, $95, $4e, $83, $4c, $4a, $9d, $92, $48, $85, $4a, $85, $48, $85, $40, $85, $44, $85, $c7
	.byte $84, $2c, $85, $2d, $2c, $85, $2c, $89, $8c, $32, $85, $37, $36, $89
	.byte $ff, $14
	.word @song0ref992
	.byte $8c, $33, $32, $89, $36, $85
	.byte $ff, $19
	.word @song0ref992
	.byte $ff, $16
	.word @song0ref992
	.byte $36, $8d
@song0ref1181:
	.byte $92
@song0ref1182:
	.byte $28, $2c, $9b, $30, $89, $32, $87, $2e, $2c, $a5, $48, $89, $4a, $89, $40, $44, $83, $9f, $4e, $89, $44, $89, $48, $a5
	.byte $40, $85, $44, $85, $48, $85, $4e, $85, $9f, $4e, $85, $4a, $85, $44, $85, $48, $4a, $a3, $96, $48, $85, $44, $85, $40
	.byte $85, $46, $48, $83, $9f, $92, $32, $89, $36, $89, $30, $8d, $96, $49, $41, $37, $41, $37, $31, $37, $31, $29, $31, $29
	.byte $1f, $29, $1e, $81
	.byte $ff, $12
	.word @song0ref1181
@song0ref1261:
	.byte $36, $89, $2c, $89, $30, $a5, $96, $2e, $30, $83, $32, $85, $36, $85, $3a, $85, $8f, $40, $95, $44, $8d, $46, $48, $a3
	.byte $92, $46, $48, $83, $40, $89, $94, $41, $92, $42, $44, $83, $f9, $85
@song0ref1299:
	.byte $8f, $84, $2c, $85, $2c, $85, $2d, $2c, $85, $2c, $85, $92, $16, $18, $87, $10, $95, $0a, $a5, $06, $95, $08, $0a, $e3
	.byte $ff, $11
	.word @song0ref1299
	.byte $12, $14, $f9, $81, $8f, $84, $2c, $85, $2c, $85, $2d, $2c, $85, $2c, $85, $96, $2e, $30, $87, $28, $95, $22, $a5, $1e
	.byte $95, $26, $28, $93, $2c, $cd, $30, $32, $ab, $34, $36, $83, $3a, $95, $40, $ad, $40, $42, $44, $f9
	.byte $ff, $1b
	.word @song0ref1036
	.byte $ff, $14
	.word @song0ref1038
	.byte $ff, $1c
	.word @song0ref1069
	.byte $ff, $0d
	.word @song0ref1077
	.byte $ff, $2c
	.word @song0ref1102
	.byte $f9, $85, $f9, $85
	.byte $ff, $49
	.word @song0ref1182
	.byte $ff, $12
	.word @song0ref1181
	.byte $ff, $22
	.word @song0ref1261
	.byte $fd
	.word @song0ch1loop
@song0ch2:
@song0ch2loop:
@song0ref1402:
	.byte $f9, $85, $f9, $85, $f9, $85, $f9, $85, $f9, $85, $f9, $85, $f9, $85
	.byte $ff, $0e
	.word @song0ref1402
	.byte $ff, $0e
	.word @song0ref1402
	.byte $ff, $0e
	.word @song0ref1402
	.byte $ff, $0e
	.word @song0ref1402
	.byte $ff, $0e
	.word @song0ref1402
	.byte $ff, $0e
	.word @song0ref1402
	.byte $f9, $85, $fd
	.word @song0ch2loop
@song0ch3:
@song0ch3loop:
	.byte $ff, $0e
	.word @song0ref1402
	.byte $ff, $0e
	.word @song0ref1402
	.byte $ff, $0e
	.word @song0ref1402
	.byte $ff, $0e
	.word @song0ref1402
	.byte $ff, $0e
	.word @song0ref1402
	.byte $ff, $0e
	.word @song0ref1402
	.byte $ff, $0e
	.word @song0ref1402
	.byte $f9, $85, $fd
	.word @song0ch3loop
@song0ch4:
@song0ch4loop:
	.byte $ff, $0e
	.word @song0ref1402
	.byte $ff, $0e
	.word @song0ref1402
	.byte $ff, $0e
	.word @song0ref1402
	.byte $ff, $0e
	.word @song0ref1402
	.byte $ff, $0e
	.word @song0ref1402
	.byte $ff, $0e
	.word @song0ref1402
	.byte $ff, $0e
	.word @song0ref1402
	.byte $f9, $85, $fd
	.word @song0ch4loop
