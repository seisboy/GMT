#!/bin/bash
# 按照数据读如的顺序排列
PS=best_ri.ps
R=-3/20/-1/84
J=X6i

gmt psxy -R$R -J$J -T -K > $PS
gmt psbasemap -J$J -R$R -Bx5+l"T (s)" -By10+l"No. of traces" -BWS -K -O >> $PS
gmt psbasemap -J$J -R$R -B0 -Ben -K -O >> $PS
gmt pssac -J$J -R$R -M0.5 -En -Fr -W0.8p,black -Gn+g128/128/105 *.SAC.Ri -K -O >> $PS
gmt pssac -J$J -R$R -M0.5 -En -Fr -W0.8p,black -G+g255/0/0 *.SAC.Ri -K -O >> $PS
gmt pssac -J$J -R$R -M0.5 -En -Fr -W0.8p,black *.SAC.Ri -K -O >> $PS
gmt pstext -J$J -R$R -TO -F+f15p,1,black -K -O >> $PS << EOF
0 81 directP
3.9 80 Ps
13 80 PpPs
17 80 PpSs+PsPs
EOF

gmt psxy -R$R -J$J -T -O >> $PS

gmt psconvert $PS -A -Tg -P
rm gmt.*
