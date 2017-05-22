#!/bin/bash
PS=Bga.ps
xyz_file=Bouguer.txt
grd_file=Bouguer.grd
cpt_file=Bouguer.cpt
xy1=SCborder.dat
xy2=YNborder.dat
R=95/110/20/35
J=M10c

gmt gmtset MAP_FRAME_WIDTH 3p
gmt gmtset MAP_TICK_LENGTH_PRIMARY 3p
gmt gmtset FONT_ANNOT_PRIMARY 7p

# 生成grd和cpt
gmt surface $xyz_file -R$R -I0.1m -G$grd_file
# gmt grd2cpt $grd_file -Cseis -Z > $cpt_file
gmt grd2cpt $grd_file -Cwysiwyg -L-485/0 -S-485/0/5 -Z > $cpt_file

# 绘图YN边界
gmt psclip $xy2 -R$R -J$J -K > $PS
gmt grdimage $grd_file -R$R -BWesN -Bx2.5 -By2.5 -J$J -C$cpt_file -K -O >> $PS
gmt psclip -C -K -O >> $PS

# 绘图SC边界
gmt psclip $xy1 -R$R -J$J -K -O >> $PS
gmt grdimage $grd_file -R$R -BWesN -Bx2.5 -By2.5 -J$J -C$cpt_file -K -O >> $PS
gmt psclip -C -K -O >> $PS

# 绘制图中的其他元素
gmt psbasemap -R$R -J$J -BWesN -Bx2.5 -By2.5 -K -O >> $PS
gmt psscale -R -J -DjCB+w10c/0.1i+o0/-0.3i+h -C$cpt_file -G-485/0 -I -Bxa100f10+l"Bouguer Gravity Anomaly (mGal)" -K -O >> $PS
# awk '{print $1,$2,$3}' $xyz_file | gmt pstext -R$R -J$J -TO -Bx2.5 -By2.5 -BWesN -F+f5p,4,black -K -O >> $PS

# 结束gmt绘图
gmt psxy -R$R -J$J -T -O >> $PS



gmt psconvert $PS -A -Tg -P
rm gmt.* *.cpt
