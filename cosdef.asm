; 
            icl 'cosdef.inc'
;
; Start of code
;
            org $2000
;
L2000       cld
            ldy #$85
            ldx #$22
            lda #$07
            jsr SETVBV
            lda #$3E
            sta SDMCTL
            lda #$03
            sta GRACTL
            lda #$22
            sta GPRIOR
            lda #$05
            sta SIZEM
            lda #$64
            sta COLOR0
            lda #$26
            sta COLOR1
            lda #$38
            sta COLOR2
            lda #$D4
            sta COLOR3
            lda #$00
            sta COLOR4
            lda #$AA
            sta PCOLR0
            lda #$36
            sta PCOLR1
            lda #$00
            sta PMBASE
            ldy #$00
L2048       lda LE000,Y
            sta L0800,Y
            sta L0C00,Y
            sta L1000,Y
            lda LE100,Y
            sta L0900,Y
            sta L0D00,Y
            sta L1100,Y
            dey
            bne L2048
            ldy #$77
L2065       lda L2B62,Y
            sta L0808,Y
            lda L2BDA,Y
            sta L0C08,Y
            lda L2C52,Y
            sta L1008,Y
            dey
            bpl L2065
            lda #$08
            sta CHBAS
L207F       jsr L2175
            jsr L20A3
            jsr L215C
            jsr L218B
            jsr L293F
            jsr L25D1
            jsr L20B6
            jsr L27F7
L2097       jsr L213A
            lda CONSOL
            cmp #$03
            bne L2097
            beq L207F
L20A3       jsr SIOINV
            lda #$00
            sta L0090
            ldy #$07
            sta AUDCTL
L20AF       sta AUDF1,Y
            dey
            bpl L20AF
            rts
L20B6       lda L2B18
            sec
            sbc #$11
            tay
            lda #$00
            sta L00D6
            lda L2131,Y
            sta L0091
            tax
L20C7       lda RANDOM
            cmp #$FA
            bcs L20C7
            tay
L20CF       lda RANDOM
            and #$3E
            cmp #$28
            bcs L20CF
            adc #$01
            jsr L20FC
            bne L20C7
            ldx L0091
L20E1       lda RANDOM
            cmp #$30
            bcc L20E1
            cmp #$FF
            beq L20E1
            tay
L20ED       lda RANDOM
            and #$3E
            cmp #$28
            bcs L20ED
            jsr L20FC
            bne L20E1
            rts
L20FC       clc
            adc #$30
            sta L00D7
            lda (L00D6),Y
            iny
            ora (L00D6),Y
            inc L00D7
            inc L00D7
            ora (L00D6),Y
            dey
            ora (L00D6),Y
            bne L2130
            dec L00D7
            dec L00D7
            lda #$01
            sta (L00D6),Y
            lda #$02
            iny
            sta (L00D6),Y
            inc L00D7
            inc L00D7
            lda #$04
            sta (L00D6),Y
            lda #$03
            dey
            sta (L00D6),Y
            lda #$30
            sta L00D7
            dex
L2130       rts
L2131       plp
            .byte $3C
            lsr ADRESS
            adc L6446,X
            bvc L219D+1
L213A       lda M0PF
            beq L2141
            sta LOMEM+1
L2141       lda M0PL
            and #$FC
            beq L214A
            sta L0082
L214A       lda P0PF
            bne L2156
            lda P0PL
            and #$FD
            beq L215B
L2156       sta LOMEM
            sta HITCLR
L215B       rts
L215C       lda #$5A
            sta L00D7
            ldx #$00
            stx L00D6
            ldy #$00
L2166       txa
            sta (L00D6),Y
            iny
            bne L2166
            dec L00D7
            lda #$2F
            cmp L00D7
            bne L2166
            rts
L2175       lda #$00
            tay
L2178       sta DDEVIC,Y
            sta L0400,Y
            sta L0500,Y
            sta L0600,Y
            sta L0700,Y
            iny
            bne L2178
            rts
L218B       lda #$00
            sta L0085
            sta LOMEM
            sta LOMEM+1
            sta L0082
            sta L0097
            sta L0098
            sta L008A
            sta L008B
L219D       sta L0095
            sta L0093
            lda #$30
            sta L0096
            lda #$13
            sta L2B05
            sta L0083
            lda #$54
            sta L2AAF
            sta HITCLR
            lda #$32
            sta L0099
            lda #$64
            sta L009A
            sta L0084
            rts
L21BF       lda L0094
            bne L21EA
            sta L0087
            sta L008B
            sta HPOSP1
            lda #$01
            sta L0094
            jsr L20A3
            jsr L2399
            lda #$64
            sta L0084
            lda #$14
            sta AUDCTL
            lda #$C8
            sta AUDF4
            lda #$87
            sta AUDC3
            sta AUDC4
L21EA       lda RANDOM
            and #$06
            sta COLPM0
            sta COLPM1
            lda RANDOM
            sta AUDF1
            lda RANDOM
            sta AUDF2
            lda RANDOM
            and #$DF
            sta AUDC1
            sta AUDC2
            dec L0084
            bne L2242
            jsr L20A3
            lda #$32
            sta L0099
            sta HITCLR
            lda #$64
            sta L009A
            lda #$00
            sta L0094
            sta LOMEM
            dec L2B05
            lda L2B05
            cmp #$10
            beq L2245
            lda #$00
            sta L0095
            lda #$30
            sta L0096
            sta HITCLR
            jsr L23D9
            jsr L2175
            jsr L27F7
L2242       jmp XITVBV
L2245       jsr L2175
            jsr L20A3
            lda #$00
            sta LOMEM
            lda #$01
            sta HITCLR
            sta L0083
            lda #$19
            sta L2AAD
            sta L2AB3
            lda #$2B
            sta L2AAE
            sta L2AB4
            lda #$4E
            sta L2AB0
            lda #$2B
            sta L2AB1
            lda #$46
            sta L2AAF
            lda #$FF
            sta CDTMF5
            sta CDTMV5
L227D       lda CDTMF5
            bne L227D
            jmp L207F
            lda #$00
            sta L00D8
            lda L0083
            bne L22D1
            sta ATRACT
            lda L0082
            beq L2299
            jsr L2878
            jsr L28DD
L2299       lda LOMEM
            beq L22A0
            jmp L21BF
L22A0       lda CH
            cmp #$21
            bne L22B2
            lda #$FF
            sta CH
            lda L0085
            eor #$FF
            sta L0085
L22B2       lda L0085
            bne L22D1
            jsr L2591
            jsr L26BC
            jsr L22E2
            jsr L230E
            jsr L2352
            jsr L24EA
            jsr L2848
            jsr L23AD
            jsr L23D9
L22D1       lda L009E
            beq L22DF
            lda #$BD
            sta VDSLST
            lda #$29
            sta VDSLST+1
L22DF       jmp XITVBV
L22E2       lda PORTA
            ldx L009A
            lsr
            bcs L22F0
            cpx #$20
            beq L22F0
            dec L009A
L22F0       lsr
            bcs L22F9
            cpx #$BE
            beq L22F9
            inc L009A
L22F9       ldx L0099
            lsr
            bcs L2304
            cpx #$32
            beq L2304
            dec L0099
L2304       lsr
            bcs L230D
            cpx #$64
            beq L230D
            inc L0099
L230D       rts
L230E       ldx L0099
L2310       stx HPOSP0
            inx
            inx
            stx HPOSM1
            ldy L009A
            ldx #$08
L231C       lda L2349,X
            sta L0400,Y
            lda DDEVIC,Y
            and #$F3
L2327       sta DDEVIC,Y
            iny
            dex
            bpl L231C
            ldy L009A
            lda DSTATS,Y
            ora #$0C
            sta DSTATS,Y
            lda DBUFLO,Y
            ora #$04
            sta DBUFLO,Y
            lda DBUFHI,Y
            ora #$0C
            sta DBUFHI,Y
            rts
L2349       .byte $00
            cpy #$70
            .byte $00,$73,$00
            bvs L2310+1
            .byte $00
L2352       lda L009B
            bne L2377
            lda TRIG0
            bne L23AC
            lda #$01
            sta L009B
            ldy L009A
            lda #$03
            sta DBUFLO,Y
            sty L0089
            lda #$25
            sta AUDC1
            lda #$32
            sta L0086
            lda L0099
            adc #$06
            sta L0088
L2377       inc L0088
            inc L0088
            lda L0088
            sta HPOSM0
            inc L0086
            inc L0086
            lda L0086
            sta AUDF1
            lda #$CD
            cmp L0088
            bcc L2399
            lda LOMEM+1
            beq L23AC
            jsr L2438
            jsr L245C
L2399       lda #$00
            sta AUDC1
            sta L009B
            sta LOMEM+1
            ldy L0089
            lda DBUFLO,Y
            and #$FC
            sta DBUFLO,Y
L23AC       rts
L23AD       lda CDTMF3
            ora L0093
            bne L23D3
            lda L2B18
            sec
            sbc #$11
            tay
            lda L2404,Y
            sta CDTMV3
            sta CDTMF3
            ldy L0097
            dey
            bpl L23D1
            inc L0095
            bne L23CF
            inc L0096
L23CF       ldy #$03
L23D1       sty L0097
L23D3       ldx L0097
            stx HSCROL
            rts
L23D9       ldy #$32
            lda L0096
            cpy L0096
            bne L23EA
            dec L0093
            bne L2403
            jsr L2549
            lda #$30
L23EA       pha
            ldx #$14
            ldy #$06
L23EF       lda L0095
            sta L2A92,Y
            iny
            pla
            sta L2A92,Y
            clc
            adc #$02
            pha
            iny
            iny
            dex
            bpl L23EF
            pla
L2403       rts
L2404       .byte $03,$03,$02,$02,$02,$02,$02
            ora (NGFLAG,X)
L240D       inc L2AF9,X
            lda L2AF9,X
            cmp #$1A
            beq L241C
L2417       dey
            beq L2425
            bne L240D
L241C       lda #$10
            sta L2AF9,X
            sta L008F
            bne L2417
L2425       lda L008F
            beq L2435
            txa
            beq L2435
            dex
            ldy #$01
            lda #$00
            sta L008F
            beq L240D
L2435       jmp L25B0
L2438       lda L0089
            sec
            sbc #$1D
            lsr
            lsr
            and #$FE
            clc
            adc L2A99
            sta L008E
            lda L0097
            asl
            clc
            adc L0088
            sec
            sbc #$27
            lsr
            lsr
            clc
            adc L0095
            sta L008D
            bcc L245B
            inc L008E
L245B       rts
L245C       lda L008D
            sta L00D6
            lda L008E
            sta L00D7
            sta HITCLR
            ldy #$00
            lda (L00D6),Y
            bne L2477
            iny
            lda (L00D6),Y
            bne L2477
            iny
            lda (L00D6),Y
            beq L245B
L2477       cmp #$01
            beq L24B7
            cmp #$02
            bne L2484
            dec L00D6
            jmp L24B7
L2484       cmp #$03
            beq L248E
            cmp #$04
            bne L2495
            dec L00D6
L248E       dec L00D7
            dec L00D7
            jmp L24B7
L2495       cmp #$0A
            bne L24A4
            lda #$0D
            sta (L00D6),Y
            inc L00D7
            inc L00D7
            jmp L24D0
L24A4       cmp #$09
            bne L245B
            lda #$0D
            sta (L00D6),Y
            dec L00D7
            dec L00D7
            dec L00D7
            dec L00D7
            jmp L24D0
L24B7       lda #$00
            sta (L00D6),Y
            inc L00D7
            inc L00D7
            sta (L00D6),Y
            iny
            sta (L00D6),Y
            dec L00D7
            dec L00D7
            sta (L00D6),Y
            ldx #$03
            ldy #$05
            bne L24DE
L24D0       lda #$00
            sta (L00D6),Y
            inc L00D7
            inc L00D7
            sta (L00D6),Y
            ldx #$02
            ldy #$02
L24DE       sta LOMEM+1
            jsr L240D
            lda #$19
            sta L0090
            jmp L2878
L24EA       lda L0090
            beq L251B
            lda CDTMF4
            bne L251B
            dec L0090
            lda L0090
            sta CDTMF4
            beq L251B
            tay
            lda L251C,Y
            sta AUDF2
            lda RANDOM
            ora #$C0
            sta AUDF3
            lda L2535,Y
            ora #$40
            sta AUDC2
L2513       sta AUDC3
            lda #$02
L2518       sta CDTMV4
L251B       rts
L251C       sbc L00F4,X
            .byte $F3,$F2,$F2
            beq L2513+2
L2523       sbc L00E9,X
            cpx #$EF
            beq L2518+2
            .byte $F2,$F3,$F4
            sbc L00F4,X
            sbc (L00F5),Y
            .byte $F2,$F3,$F4
            sbc L00F5,X
L2535       .byte $00,$00
            ora (CASINI,X)
            .byte $03,$04
            ora RAMLO+1
            asl TRAMSZ
            .byte $07,$07
            php
            php
            ora #$09
            ora #$0A
            asl
            asl
L2549       inc L2B18
            lda L2B18
            cmp #$1A
            bne L2558
            lda #$14
            sta L2B18
L2558       lda #$40
            sta NMIEN
            php
            sei
            jsr L215C
            lda #$00
            sta L0095
            sta L009B
            jsr L20A3
            lda #$30
            sta L0096
            jsr L23D9
            sta HITCLR
            jsr L25D1
            jsr L20B6
            lda #$00
            ldx #$0A
L257F       sta L00B5,X
            dex
            bpl L257F
            jsr L27F7
            inc L2B05
            plp
            lda #$C0
            sta NMIEN
            rts
L2591       lda CDTMF5
            bne L25AF
            lda #$04
            sta CDTMV5
            sta CDTMF5
            lda CHBAS
            cmp #$10
            beq L25AA
            clc
            adc #$04
            bne L25AC
L25AA       lda #$08
L25AC       sta CHBAS
L25AF       rts
L25B0       ldy #$00
L25B2       lda L2AF9,Y
            cmp L2B0B,Y
            beq L25BE
            bcc L25D0
            bcs L25C3
L25BE       iny
            cpy #$04
            bne L25B2
L25C3       ldy #$00
L25C5       lda L2AF9,Y
            sta L2B0B,Y
            iny
            cpy #$04
            bne L25C5
L25D0       rts
L25D1       lda L2B18
            sec
            sbc #$11
            tax
            lda L2663,X
            sta L0091
            ldy #$00
            lda #$30
            sta L0092
            lda L266B+1,X
            sta L00D6
L25E8       lda L0092
            sta L00D7
            ldx #$07
L25EE       lda #$05
            sta (L00D6),Y
            inc L00D7
            inc L00D7
            lda #$06
            sta (L00D6),Y
            inc L00D7
            inc L00D7
            lda #$07
            sta (L00D6),Y
            inc L00D7
            inc L00D7
            dex
            bne L25EE
L2609       lda RANDOM
            and #$1F
            cmp #$14
            bcs L2609
            cmp #$05
            bcc L2609
            dec L00D6
            asl
            clc
            adc L0092
            sta L00D7
            lda #$08
            sta (L00D6),Y
            dec L00D7
            dec L00D7
            lda #$09
            sta (L00D6),Y
            dec L00D7
            dec L00D7
            lda #$8C
            sta (L00D6),Y
            iny
            lda #$00
            sta (L00D6),Y
            dec L00D7
            dec L00D7
            sta (L00D6),Y
            dey
            lda #$8B
            sta (L00D6),Y
            dec L00D7
            dec L00D7
            lda #$0A
            sta (L00D6),Y
            dec L00D7
            dec L00D7
            lda #$08
            sta (L00D6),Y
            lda L00D6
            adc L0091
            sta L00D6
            bcc L25E8
            inc L0092
            lda L0092
            cmp #$31
            beq L25E8
            rts
L2663       .byte $FF
            stx NOCKSM,Y
            asl L3C1E,X
            .byte $3C,$5A
L266B       lsr L00FF
            iny
            .byte $64,$4B,$32,$32,$32
            iny
            .byte $64
            pha
            txa
            pha
            ldx L00D8
            inc L00D8
            lda L00AA,X
            sta HPOSP3
            sta HPOSP2
            lda L00C0,X
            sta COLPM2
            lda L00CB,X
            sta COLPM3
            cpx #$0A
            bne L269C
            lda #$A0
            sta VDSLST
            lda #$26
            sta VDSLST+1
L269C       pla
            tax
            pla
            rti
            pha
            lda #$F8
            sta COLPF0
            lda #$98
            sta COLPF1
            lda #$26
            sta COLPF3
            lda #$75
            sta VDSLST
            lda #$26
            sta VDSLST+1
            pla
            rti
L26BC       ldx #$00
            stx L00D8
L26C0       lda L009F,X
            beq L26D7
            lda L00AA,X
            sec
            sbc L009F,X
            bne L26CF
            sta L009F,X
            lda #$FE
L26CF       sta L00AA,X
L26D1       inx
            cpx #$0A
            bne L26C0
            rts
L26D7       lda L0093
            ora RANDOM
            bne L26D1
            lda #$01
            ldy RANDOM
            cpy #$0F
            bcs L26E9
            lda #$02
L26E9       sta L009F,X
            lda L2B18
            cmp #$16
            bcc L26F4
            inc L009F,X
L26F4       jmp L26D1
L26F7       .byte $00,$00,$00,$00,$00,$00
            sei
            .byte $FC
            sei
            .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$1C
            rol L6B7F,X
            .byte $7F
            eor L1C22,X
            .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$7F
            sed
            .byte $7F,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
            clc
            .byte $3C
            ror L5A3C,X
            ror COUNTR
            .byte $3C
            clc
            .byte $00,$00,$00,$00,$00,$00,$00,$07,$0F
            asl.w ABUFPT
            .byte $1C
            asl L070F
            .byte $00,$00,$00,$00,$00,$00,$00,$00,$00
            bit L2F24
            and L0F09,X
            .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
L275D       bpl L2797
            .byte $7C
            sec
            bpl L2763
L2763       .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$02,$07,$02,$00,$00
            .byte $00,$00,$00,$00
L2777       .byte $00,$00,$00,$07
            asl.w NOCKSM
            .byte $FC,$00,$3C
            asl.w CMCMD
            .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$14,$00,$22,$1C,$00,$00
            .byte $00,$00,$00
L2797       .byte $00,$00,$00,$00,$03,$07,$3F,$3F
L279F       .byte $3F,$07,$03,$00,$00,$00,$00,$00,$00,$00,$00
            clc
            bit CRITIC
            sta (L00C3,X)
            .byte $E7,$FF
            ror L183C,X
            .byte $00,$00,$00,$00,$00,$00,$00,$0F,$00,$00,$00,$FC,$00,$00,$00,$0F
            .byte $00,$00,$00,$00,$00,$00,$00
            beq L275D
            bcc L279F
            .byte $0B
            ora #$09
            .byte $0F,$00,$00,$00,$00,$00,$00,$00,$00,$00
            bpl L2806
            .byte $44,$92,$44
            plp
            bpl L27E4
L27E4       .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$02,$00,$00,$00,$00
            .byte $00,$00,$00
L27F7       lda L2B18
            cmp #$11
            beq L2847
            lda #$0A
            sta L0091
L2802       ldy #$0F
            lda L0091
L2806       asl
            asl
            asl
            asl
            clc
            adc #$22
            tax
L280E       lda L2777,Y
            sta L0600,X
            lda L26F7,Y
            sta L0700,X
            dex
            dey
            bne L280E
            dec L0091
            bne L2802
            ldx #$0A
L2824       lda #$FE
            sta L00AA,X
            lda #$00
            sta L009F,X
            dex
            bpl L2824
            ldx #$09
            lda #$04
L2833       clc
            adc #$50
            sta L00C0,X
            dex
            bpl L2833
            ldx #$09
            lda #$88
L283F       clc
            adc #$30
            sta L00CB,X
            dex
            bpl L283F
L2847       rts
L2848       lda L008B
            beq L2877
            dec L008C
            bne L2877
            dec L008B
            lda L008B
            asl
            asl
            asl
            ora #$07
            tax
            lda #$08
            sta L0092
            ldy L008A
L2860       lda L2895,X
            sta L0500,Y
            dex
            iny
            dec L0092
            bne L2860
            lda #$06
            sta L008C
            lda L008B
            bne L2877
            sta HPOSP1
L2877       rts
L2878       ldx #$07
            lda #$08
            sta L0092
            ldy L008A
            jsr L2860
            lda L0089
            sta L008A
            lda L0088
            sta HPOSP1
            lda #$09
            sta L008B
            lda #$01
            sta L008C
            rts
L2895       .byte $00,$00,$00,$00,$00,$00,$00,$00
            sta (L0000,X)
            .byte $00,$00,$00,$00,$00
            sta (LOMEM+1,X)
            .byte $42,$00,$00,$00,$00,$42
            sta (L0089,X)
            .byte $42
            bit LOMEM
            ora (ICBALZ,X)
            .byte $42
            sta (WARMST),Y
            lsr
            bit L00C0
            .byte $03
            bit LMARGN
            ora L0808,X
            bit L07E0
            .byte $34
            bpl L28D5
            .byte $00
            php
            php
            sei
            asl L1010,X
            .byte $00,$00,$00
            php
            sec
            .byte $1C
            bpl L28D4
L28D4       .byte $00
L28D5       .byte $00,$00,$00
            clc
            clc
            .byte $00,$00,$00
L28DD       lda L0089
            sec
            sbc #$1C
            lsr
            lsr
            lsr
            lsr
            tax
            lda #$00
            sta L009F,X
            lda #$FE
            sta L00AA,X
            inc L00B5,X
            lda L00B5,X
            sta L0091
            stx L0092
            tay
            ldx #$02
            jsr L240D
            ldx L0092
            ldy L0091
            cpy #$08
            bcc L290B
            lda #$00
            sta L00B5,X
            sta L0091
L290B       lda #$17
            sta L0090
            txa
            asl
            asl
            asl
            asl
            clc
            adc #$31
            tay
            lda L0091
            asl
            asl
            asl
            asl
            sta L0091
            ora #$0F
            tax
L2923       lda L2777,X
            sta L0600,Y
            lda L26F7,X
            sta L0700,Y
            dey
            dex
            cpx L0091
            bne L2923
            stx HITCLR
            lda #$00
            sta L0082
            jmp L2399
L293F       lda #$05
            sta SDLSTL
            lda #$2A
            sta SDLSTH
            jsr L2175
            lda #$C0
            sta NMIEN
            inc L009E
            lda L29BC
            sta L2B18
L2959       lda CONSOL
            cmp #$05
            bne L2977
            inc L2B18
            lda L2B18
            cmp #$1A
            bne L296C
            lda #$11
L296C       sta L2B18
            lda #$1E
            sta CDTMV5
            sta CDTMF5
L2977       lda L2B18
            sta L2A7C
            jsr L2591
            lda TRIG0
            beq L298C
            lda CONSOL
            cmp #$06
            bne L29B5
L298C       lda #$92
            sta SDLSTL
            lda #$2A
            sta SDLSTH
            lda #$75
            sta VDSLST
            lda #$26
            sta VDSLST+1
            lda #$10
            ldy #$05
L29A4       sta L2AF7+1,Y
            dey
            bne L29A4
            sty L0083
            sty L009E
            lda L2B18
            sta L29BC
            rts
L29B5       lda CDTMF5
            bne L2977
            beq L2959
L29BC       ora (FMSZPG+5),Y
            txa
            pha
            ldx #$0F
            lda L009D
            sta L009C
L29C6       lda L009C
            sta WSYNC
            sta COLPF0
            clc
            adc #$02
            sta L009C
            dex
            bpl L29C6
            ldx #$0F
L29D8       lda L009C
            sta WSYNC
            sta COLPF0
            sec
            sbc #$02
            sta L009C
            dex
            bpl L29D8
            lda CDTMF4
            bne L29F7
            lda #$01
            sta CDTMF4
            sta CDTMV4
            inc L009D
L29F7       lda #$A0
            sta VDSLST
L29FC       lda #$26
            sta VDSLST+1
            pla
            tax
            pla
            rti
            bvs L2A76+1
            lsr L00DE
            rol
            bvs L29FC
            .byte $47
            bmi L2A39
            .byte $47
            rol L702A,X
            bvs L2A5B
            jmp L462A
            .byte $5B
            rol
            beq L2A62+1
            ror L702A,X
            dec BUFSTR
            rol
            bvs L2A94
            bvs L2A96
            bvs L2A98
            lsr L00DE
            rol
            asl TRAMSZ
            eor (RAMLO+1,X)
            rol
            .byte $00,$00,$00,$00,$00,$00,$00,$23,$2F
L2A39       .byte $33
            and L2327+2
            .byte $00,$00,$00,$00,$00,$00,$00
            bit ICBAHZ
            rol ICBAHZ
L2A48       rol L2523+1
            .byte $32,$80,$80,$80,$80,$80,$80,$80,$80,$80
            ldx #$B9
            .byte $80,$80,$80,$80
L2A5B       .byte $80,$80,$80,$80,$80
            beq L2A48+2
L2A62       sbc #$EC
            cpx LF280
            .byte $EF
            sbc L00F9
            .byte $80,$80,$00,$00,$00,$73
            adc BUFSTR
            adc LOGCOL
            .byte $74,$00
L2A76       jmp (L7665)
            adc BUFSTR
            .byte $1A
L2A7C       .byte $00,$00,$80,$80
            sbc (L00EE,X)
            sbc (L00EC,X)
            .byte $EF,$E7,$80,$E3,$EF
            sbc LF5F0
            .byte $F4
            sbc #$EE
            .byte $E7,$80,$80
L2A92       bvs L2B04
L2A94       dec L00DE
L2A96       rol
            .byte $54
L2A98       .byte $00
L2A99       .byte $00,$D4,$00,$00,$54,$00,$00,$D4,$00,$00,$54,$00,$00,$D4,$00,$00
            .byte $54,$00,$00,$D4
L2AAD       .byte $00
L2AAE       .byte $00
L2AAF       .byte $54
L2AB0       .byte $00
L2AB1       .byte $00,$D4
L2AB3       .byte $00
L2AB4       .byte $00,$54,$00,$00,$D4,$00,$00,$54,$00,$00,$D4,$00,$00,$54,$00,$00
            .byte $D4,$00,$00,$54,$00,$00,$D4,$00,$00,$54,$00,$00,$D4,$00,$00,$54
            .byte $00,$00
            dec L00DE
            rol
            asl TRAMSZ
            eor (L0092,X)
            rol
            stx L8E8E
            stx L8E8E
            stx L8E8E
            stx L8E8E
            stx L8E8E
            stx L8E8E
            stx L808E
            .byte $F3,$E3,$EF,$F2
L2AF7       sbc L009A
L2AF9       bpl L2B0B
            bpl L2B0D
            bpl L2AFF
L2AFF       jmp (L7669)
            adc COLAC+1
L2B04       .byte $1A
L2B05       .byte $13,$00,$00
            pla
            adc #$1A
L2B0B       bpl L2B1D
L2B0D       bpl L2B1F
            bpl L2B11
L2B11       .byte $00
            jmp (L7665)
            adc BUFSTR
            .byte $1A
L2B18       ora (L0000),Y
            .byte $00,$00,$00
L2B1D       .byte $00,$00
L2B1F       .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$27
            and (ICAX4Z,X)
            and L0000
            .byte $00,$2F
            rol ICBAHZ,X
            .byte $32,$00,$00,$00,$00,$00
L2B62       .byte $00
            ora (NGFLAG,X)
            .byte $14
            ora (DSKUTL),Y
            ora COLCRS,X
            .byte $00
            rti
            bvc L2BBE
            .byte $64,$54
            eor HOLD1
            eor L1A59,Y
            ora BRKKEY,X
            ora NGFLAG
            .byte $00
            adc #$58
            .byte $54,$54
            bvc L2BC0
            .byte $00,$00,$FF,$FF,$D7,$D7,$D7,$D7,$FF,$FF,$FF,$FF,$C3,$C3,$C3,$C3
            .byte $FF,$FF,$FF,$FF,$EB,$EB,$EB,$EB,$FF,$FF,$0F,$03,$03,$0F,$0F,$03
            .byte $03,$0F,$3F
            sbc L00F5,X
            nop
            nop
            sbc L00F5,X
            .byte $3F,$3F
            sbc L00F5,X
            nop
            nop
            sbc L00F5,X
            .byte $3F,$C3,$3C,$00
L2BB5       .byte $C3,$3C,$00,$C3
L2BB9       .byte $3C,$00,$C3,$3C,$00
L2BBE       .byte $C3,$3C
L2BC0       .byte $00,$C3,$3F
            beq L2BB5
            cpy #$C0
            beq L2BB9
            .byte $3F,$FF
            eor #$49
            eor #$49
            eor #$49
            .byte $FF,$00
            asl L2D21,X
            and #$2D
            and (ABUFPT+2,X)
L2BDA       .byte $00
            ora (NGFLAG,X)
            .byte $14
            ora (DSKUTL),Y
            ora COLCRS,X
            .byte $00
            rti
            bvc L2C36
            .byte $64,$54
            eor HOLD1
            eor L1A59,Y
            ora BRKKEY,X
            ora NGFLAG
            .byte $00
            adc #$58
            .byte $54,$54
            bvc L2C38
            .byte $00,$00,$FF,$FF,$EB,$EB,$EB,$EB,$FF,$FF,$FF,$FF,$D7,$D7,$D7,$D7
            .byte $FF,$FF,$FF,$FF,$C3,$C3,$C3,$C3,$FF,$FF,$0F,$03,$03,$0F,$0F,$03
            .byte $03,$0F,$3F
            sbc L00F5,X
            cpy #$C0
            sbc L00F5,X
            .byte $3F,$3F
            sbc L00F5,X
            cpy #$C0
            sbc L00F5,X
            .byte $3F,$00,$C3,$3C
L2C2D       .byte $00,$C3,$3C,$00
L2C31       .byte $C3,$3C,$00,$C3,$3C
L2C36       .byte $00,$C3
L2C38       .byte $3C,$00,$3F
            beq L2C2D
            cpy #$C0
            beq L2C31
            .byte $3F,$FF,$92,$92,$92,$92,$92,$92,$FF,$00
            asl L2D21,X
            and #$2D
            and (ABUFPT+2,X)
L2C52       .byte $00
            ora (NGFLAG,X)
            .byte $14
            ora (DSKUTL),Y
            ora COLCRS,X
            .byte $00
            rti
            bvc L2CAE
            .byte $64,$54
            eor HOLD1
            eor L1A59,Y
            ora BRKKEY,X
            ora NGFLAG
            .byte $00
            adc #$58
            .byte $54,$54
            bvc L2CB0
            .byte $00,$00,$FF,$FF,$C3,$C3,$C3,$C3,$FF,$FF,$FF,$FF,$EB,$EB,$EB,$EB
            .byte $FF,$FF,$FF,$FF,$D7,$D7,$D7,$D7,$FF,$FF,$0F,$03,$03,$0F,$0F,$03
            .byte $03,$0F,$3F
            sbc L00F5,X
            cmp L00D5,X
            sbc L00F5,X
            .byte $3F,$3F
            sbc L00F5,X
            cmp L00D5,X
            sbc L00F5,X
            .byte $3F,$3C,$00,$C3
L2CA5       .byte $3C,$00,$C3,$3C
L2CA9       .byte $00,$C3,$3C,$00,$C3
L2CAE       .byte $3C,$00
L2CB0       .byte $C3,$3C,$3F
            beq L2CA5
            cpy #$C0
            beq L2CA9
            .byte $3F,$FF
            bit ICBALZ
            bit ICBALZ
            bit ICBALZ
            .byte $FF,$00
            asl L2D21,X
            and #$2D
            and (ABUFPT+2,X)
            .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;
            org $02E0
;
            .word L2000
;
         
