#!/bin/bash
PS=big_small5.ps
eqfile=SCYN.txt

gmt gmtset FORMAT_GEO_MAP=ddd:mm:ssF

# 绘制左底图
R=70/135/15/55
J=M12c
gmt grdcut gebco_08.nc -R$R -GcutTopo.grd
gmt grdgradient cutTopo.grd -Ne0.7 -A50 -GcutTopo_i.grd
gmt grd2cpt cutTopo.grd -Cglobe -S-10000/10000/200 -Z -D > colorTopo.cpt

gmt psxy -R$R -J$J -T -K > $PS
gmt psbasemap -R$R -J$J -Ba10f10 -BWesN -K -O >> $PS
gmt grdimage cutTopo.grd -R$R -J$J -IcutTopo_i.grd -CcolorTopo.cpt -Q -O -K >>$PS
gmt pscoast -R$R -J$J -Dh -W1/0.2p -I1/0.25p -N1/0.5p -O -K >>$PS
gmt psscale -R$R -J$J -DjCB+w12c/0.15i+o0/-0.3i+h -CcolorTopo.cpt -Bxa2000f400+l"Elevation/m" -G-8000/8000 -O -K >> $PS
awk '{print $3,$4}' $eqfile | gmt psxy -R$R -J$J -St0.07i -Gred -O -K >> $PS
gmt psxy CN-border-La.dat -J$J -R$R -W0.7p -K -O >> $PS
rm gmt.* cutTopo*.grd colorTopo.cpt


# 绘制红色矩形
gmt psxy -R$R -J$J -W1.5p,red -K -O -L >> $PS << EOF
95 20
110 20
110 35
95 35
EOF

# 绘制右底图
R=95/110/20/35
J=M7c
gmt grdcut gebco_08.nc -R$R -GcutTopo.grd
gmt grdgradient cutTopo.grd -Ne0.7 -A50 -GcutTopo_i.grd
gmt grd2cpt cutTopo.grd -Cglobe -S-10000/10000/200 -Z -D > colorTopo.cpt

gmt psbasemap -R$R -J$J -Ba5f5 -BwEsN -X13.5c -Y1c -K -O >> $PS
gmt grdimage cutTopo.grd -R$R -J$J -IcutTopo_i.grd -CcolorTopo.cpt -Q -O -K >>$PS
gmt pscoast -R$R -J$J -Dh -W1/0.2p -I1/0.25p -N1/0.5p -O -K >>$PS
awk '{print $3,$4}' $eqfile | gmt psxy -R$R -J$J -St0.12i -Gred -O -K >> $PS
gmt psxy CN-border-La.dat -J$J -R$R -W0.7p -K -O >> $PS


# 绘制辅助底图
R=50/200/0/50
J=m1/1
B=a1g1
# gmt set MAP_FRAME_TYPE=inside MAP_GRID_PEN_PRIMARY=0p,red,.
# gmt psbasemap -R$R -J$J -B$B -BWSEN -K -O -Xf0c -Yf0c >> $PS
# 在辅助底图坐标系中绘制两条连线，注意 -Xf0c 和 -Yf0c
gmt psxy -R$R -J$J -W2p,blue -K -O -Xf0c -Yf0c >> $PS << EOF
>
59.95 3.5
65.86 3.41
>
59.95 6.65
65.86 11.59
EOF

# 结束绘图
gmt psxy -R$R -J$J -T -O >> $PS
gmt psconvert $PS -A -Tg -P
rm gmt.* cutTopo*.grd colorTopo.cpt
