#!/bin/bash
PS=ri_baz1.ps
PSS=ri_baz2.ps
R=-3/50/-1/100
RR=-3/50/0/360
J=X6i

# PS1
gmt psxy -R$R -J$J -T -K > $PS
gmt psbasemap -J$J -R$R -Bx5+l"T (s)" -By10+l"Baz (degree)" -BWS -K -O >> $PS
gmt psbasemap -J$J -R$R -B0 -Ben -K -O >> $PS
gmt pssac -J$J -R$R -M0.5 -En -Fr -W0.8p,black -Gn+g128/128/105 *.SAC.Ri -K -O >> $PS
gmt pssac -J$J -R$R -M0.5 -En -Fr -W0.8p,black -G+g255/0/0 *.SAC.Ri -K -O >> $PS
gmt pssac -J$J -R$R -M0.5 -En -Fr -W0.8p,black *.SAC.Ri -K -O >> $PS
gmt psxy -R$R -J$J -T -O >> $PS

# PS2
gmt psxy -R$RR -J$J -T -K > $PSS
gmt psbasemap -J$J -R$RR -Bx5+l"T (s)" -By10+l"Baz (degree)" -BWS -K -O >> $PSS
gmt psbasemap -J$J -R$RR -B0 -Ben -K -O >> $PSS
gmt pssac -J$J -R$RR -M0.5 -Ebt -Fr -W0.8p,black -Gn+g128/128/105 *.SAC.Ri -K -O >> $PSS
gmt pssac -J$J -R$RR -M0.5 -Ebt -Fr -W0.8p,black -G+g255/0/0 *.SAC.Ri -K -O >> $PSS
gmt pssac -J$J -R$RR -M0.5 -Ebt -Fr -W0.8p,black *.SAC.Ri -K -O >> $PSS
gmt psxy -R$RR -J$J -T -O >> $PSS

gmt psconvert $PS -A -Tg -P
gmt psconvert $PSS -A -Tg -P
rm gmt.*
