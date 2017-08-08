#!/bin/bash
R=95/110/20/35
J=M102.5/27.5/5i
PS=SCYNinsert7.ps
fill=255/235/205

gmt set MAP_GRID_PEN_PRIMARY 0.25p,gray,2_2:1
gmt set FORMAT_GEO_MAP ddd:mm:ssF MAP_FRAME_WIDTH 7p
gmt set FONT_ANNOT_PRIMARY 16p
# 设置比例尺标签为35号中文字体
gmt set FONT_LABEL 8p,35 MAP_LABEL_OFFSET 4p

# 绘制中国地图
# gmt pscoast -J$J -R$R -G244/243/239 -S167/194/223 -B10f5g10 -K > $PS
gmt pscoast -J$J -R$R -BWeSn -G244/243/239 -S167/194/223 -Ba5f5 -K > $PS
gmt psxy CN-border-La.dat -J$J -R$R -W0.5p -O -K >> $PS
gmt psxy SCborder.dat -J$J -R$R -G$fill -W0.5p -O -K >> $PS
gmt psxy YNborder.dat -J$J -R$R -G$fill -W0.5p -O -K >> $PS
gmt pstext -J$J -R$R -TO -F+f25p,9,black -K -O >> $PS << EOF
102.5 30.5 SC
101.5 24.5 YN
EOF

# 开始绘制insert map
Rg=70/135/15/55     # 大区域地图的范围-R
Jg=M4c              # 大区域地图的投影方式-J
# 绘制大区域地图的海岸线及边框
gmt pscoast -R$Rg -J$Jg -G244/243/239 -S167/194/223 -B0 -B+gwhite -Df -N1 -W -A5000 -K -O --MAP_FRAME_TYPE=plain >> $PS
gmt psxy CN-border-La.dat -J$Jg -R$Rg -W0.2p -K -O >> $PS
gmt psxy SCborder.dat -J$Jg -R$Rg -G$fill -W0.2p -O -K >> $PS
gmt psxy YNborder.dat -J$Jg -R$Rg -G$fill -W0.2p -O -K >> $PS
# 在大区域地图内绘制小区域所在的方框
gmt psbasemap -R$Rg -J$Jg -D$R -F+p2p,blue -K -O >> $PS

# 结束GMT绘图
gmt psxy -R$R -J$J -T -O >> $PS
gmt psconvert $PS -A -Tg -P
rm gmt.conf gmt.history
