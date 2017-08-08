#!/bin/bash

PS=station_site.ps
eqfile=SCYN.txt
# R=70/135/15/55
R=95/110/20/35
J=M5i

gmt gmtset FORMAT_GEO_MAP=ddd:mm:ssF

gmt grdcut gebco_08.nc -R$R -GcutTopo.grd
gmt grdgradient cutTopo.grd -Ne0.7 -A50 -GcutTopo_i.grd
gmt grd2cpt cutTopo.grd -Cglobe -S-10000/10000/200 -Z -D > colorTopo.cpt

# 绘制底图
gmt psbasemap -R$R -J$J -Ba5f5 -BWesN -Xc -Yc -K > $PS
gmt grdimage cutTopo.grd -R$R -J$J -IcutTopo_i.grd -CcolorTopo.cpt -Q -O -K >>$PS
gmt pscoast -R$R -J$J -Dh -W1/0.2p -I1/0.25p -N1/0.5p -O -K >>$PS

# 绘制colorbar
gmt psscale -R$R -J$J -DjCB+w5i/0.15i+o0/-0.5i+h -CcolorTopo.cpt -Bxa2000f400+l"Elevation/m" -G-8000/8000 -O -K >>$PS

# 绘制台站位置
awk '{print $3,$4}' $eqfile | gmt psxy -R$R -J$J -St0.13i -Gred -O -K >> $PS

# 绘制国界、省界数据
gmt psxy CN-border-La.dat -J$J -R$R -W0.7p -K -O >> $PS

gmt psxy -R$R -J$J -T -O >>$PS
gmt psconvert $PS -A -Tg -P
rm gmt.* cutTopo*.grd colorTopo.cpt
