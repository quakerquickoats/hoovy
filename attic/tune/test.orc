sr    =44100
kr    =22050
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