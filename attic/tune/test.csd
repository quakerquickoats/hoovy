<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
;-odac     ;;;realtime audio out
;-iadc    ;;;uncomment -iadc if realtime audio input is needed too
; For Non-realtime ouput leave only the line below:
; -o fmmetal.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>
;sr    =44100
;kr    =22050
sr = 96000
kr = 48000
ksmps =    2
nchnls=    2

instr 1

  ilen    =        p3
  iamp    =        p4
  ifrq    = cpspch(p5)
  ifcoenv =        p6

  i_distortion_table = 2

  irezenv = 8
  iaccnt1 = 0.7

  kenv   linseg   0, .004, 1, ilen-.024, 0.5, .02, 0

  kfcoo  linseg   .3, .04, 1, .1, .6, ilen-.14, .3
  kacct2 linseg   1/iaccnt1, .04, iaccnt1, .1, 1/iaccnt1, ilen-.14, 1/iaccnt1
  kfco   =        kfcoo*ifcoenv*kacct2
  krez   =        irezenv*kacct2
  ifqcadj =       .149659863*sr
  klfo1  oscili   .1, 1.0, 1
  klfo2  oscili   .1, 1.1, 1, .21
  
  abuzz1         buzz     1,ifrq, sr/2/ifrq, 1
  abuzz1_delayed vdelay   abuzz1, 1000/ifrq/(klfo1+1)/2, 1000/22
  abuzz1_diff    =        abuzz1 - abuzz1_delayed
  apwmdc1        integ    abuzz1_diff
  
  abuzz2         buzz     1,ifrq*.995, sr/2/ifrq, 1 ; Avoid aliasing
  abuzz2_delayed vdelay   abuzz2, 1000/ifrq/(klfo2+1)/2*.995, 1000/22
  abuzz2_diff    =        abuzz2 - abuzz2_delayed
  apwmdc2        integ    abuzz2_diff
  
  abuzz3         buzz     1,ifrq*.997, sr/2/ifrq, 1 ; Avoid aliasing
  abuzz3_delayed vdelay   abuzz3, 1000/ifrq/(klfo2+1)/2*.997, 1000/22
  abuzz3_diff    =        abuzz3 - abuzz3_delayed
  apwmdc3        integ    abuzz3_diff
  
  axn    =       apwmdc1+apwmdc2+apwmdc3

  ; Resonant Lowpass Filter (4 Pole)
  kc     =        ifqcadj/kfco
  krez2  =        krez/(1+exp(kfco/11000))
  ka1    =        kc/krez2-1
  kasq   =        kc*kc
  kb     =        1+ka1+kasq
  
  ayn    nlfilt   axn/kb, (ka1+2*kasq)/kb, -kasq/kb, 0, 0, 1
  ayn2   nlfilt   ayn/kb, (ka1+2*kasq)/kb, -kasq/kb, 0, 0, 1

  
  ; Resonant Lowpass Filter (4 Pole)
  kcl    =        ifqcadj/kfco
  krez2l =        2.0/(1+exp(kfco/11000))
  ka1l   =        kcl/krez2l-1
  kasql  =        kcl*kcl
  kbl    =        1+ka1l+kasql
  
  aynl   nlfilt  axn/kbl, (ka1l+2*kasql)/kbl, -kasql/kbl, 0, 0, 1
  ayn2l  nlfilt  aynl/kbl, (ka1l+2*kasql)/kbl, -kasql/kbl, 0, 0, 1
  
  arez   =       (ayn2-ayn2l)*.5
  aclip  tablei  arez, i_distortion_table, 1, .5
  aout   =       aclip*.5+ayn2l

  outs aout*iamp*kenv, aout*iamp*kenv
endin

instr 2
  iptch = cpspch(p5)
  asig pluck p4, iptch, iptch*0.81, 1, 3, .5
  out asig
endin
</CsInstruments>
<CsScore>

f1  0 8193 10 1              ; Sine
f2  0 65537 8 1  8193 .99 8192 .96 8192 .9 4096 -.8 8192 -.8 4096 -.9 8192 -.96 8192 -.99 8192 -1
;f2  0 65537 7 1  65537 -1

;f15 0 1025 8 .99 256 0.7 512 0.9 256 1

t0 90

i1 0 0.2 8000 6.04 200   
i1 + 0.4 8000 6.04 <
i1 + 0.2 8000 6.04 <
i1 + 0.4 8000 6.07 <
i1 + 0.2 8000 6.09 <
i1 + 0.4 8000 7.04 <
i1 + 0.2 8000 6.10 <

i1 + 0.2 8000 6.04 <
i1 + 0.4 8000 6.04 <
i1 + 0.2 8000 6.04 <
i1 + 0.4 8000 6.07 <
i1 + 0.2 8000 6.09 <
i1 + 0.4 8000 7.04 <
i1 + 0.2 8000 6.10 2000


f1 0 8 2  1 1 1 1 1 -1 -1 -1

;t 30

i2     0         0.2        10000     8.00 
i2     +         0.2        10000     8.00 
i2     +         0.3        10000     8.00 
i2     +         0.1        10000     8.00 
i2     +         0.2        10000     8.00 
i2     +         0.2        10000     8.00 

</CsScore>
</CsoundSynthesizer>