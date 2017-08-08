#!/bin/bash

PS=SCYN3.ps
stafile=SCYN.txt
evefile=SCYN_allevents_info.txt
R=-80/280/-50/75
# R=70/135/15/55
# R=95/110/20/30

# gmt grdcut topo30.grd -R$R -GcutTopo.grd
# gmt grdgradient cutTopo.grd -Ne0.7 -A50 -GcutTopo_i.grd
# gmt grd2cpt cutTopo.grd -Cglobe -S-10000/10000/200 -Z -D > colorTopo.cpt

# 绘制底图
gmt gmtset FORMAT_GEO_MAP=ddd:mm:ssF
gmt psbasemap -R$R -JM7i -Bxa50f50 -Bya30f30 -BWSen -Xc -Yc -K > $PS
# gmt grdimage cutTopo.grd -R -J -IcutTopo_i.grd -CcolorTopo.cpt -Q -O -K >>$PS
gmt pscoast -R -J -A10000 -Ggrey -O -K >>$PS

# 绘制colorbar
# gmt psscale -R -J -DjCB+w7i/0.15i+o0/-0.5i+h -CcolorTopo.cpt -Bxa2000f400+l"Elevation/m" -G-8000/8000 -O -K >>$PS

# 绘制台站位置
awk '{print $3,$4}' $stafile | gmt psxy -R -J -Sc0.03i -Gred -O -K >> $PS

#分震级绘制地震
awk '$4>=6.5 && $4<7.0 {print $2,$3,$4*0.04}' $evefile | gmt psxy -R -J -Sc -Gblue -O -K >> $PS
awk '$4>=7.0 && $4<7.5 {print $2,$3,$4*0.04}' $evefile | gmt psxy -R -J -Sc -Gbrown -O -K >> $PS
awk '$4>=7.5 && $4<8.0 {print $2,$3,$4*0.08}' $evefile | gmt psxy -R -J -Sa -Ggreen -W0.4p,black -O -K >> $PS
awk '$4>=8.0 {print $2,$3,$4*0.08}' $evefile | gmt psxy -R -J -Sa -Gpurple -W0.4p,black -O -K >> $PS

#绘制图例
gmt pslegend -R -J -DjBR+w0.8i+l1.2+o0 -F+g229+p0.25p -O -K >> $PS <<EOF
G 0.01i
H 8 4 MAGNITUDE
C blue
S 0.1i c 0.20 blue 0.25p,blue 0.18i 6.5~7.0
C brown
S 0.1i c 0.24 brown 0.25p,brown 0.18i 7.0~7.5
C green
S 0.1i a 0.42 green 0.25p,black 0.18i 7.5~8.0
C purple
S 0.1i a 0.48 purple 0.25p,black 0.18i 8.0~8.9
EOF

# 绘制国界、省界数据
# gmt psxy CN-border-La.dat -J -R$R -W0.5p -K -O >> $PS

gmt psxy -R -J -T -O >>$PS
gmt psconvert $PS -A -Tg -P
rm gmt.*
