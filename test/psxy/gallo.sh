#!/bin/bash
# Test EPS symbols in psxy
ps=gallo.ps

# Get the height of EPS file relative to width
scale=`grep "%%BoundingBox" gallo.eps | awk '{print ($5-$3)/($4-$2)}'`
cat << EOF > chicks.txt
-23 34 4c
-35 15 5c
-10 10 1i
-15 55 3i
-40 65 2i
EOF
psxy -Skgallo -R-45/0/0/70 -JX15c/0 -B5 -BWSen -P -K chicks.txt -Xc > $ps
awk '{printf "%s %s %s %g%s\n", $1, $2, $3, substr($3,1,1)*'"$scale"', substr($3,2,1)}' chicks.txt > r.txt
psxy -R -J -O -K r.txt -Sr -Wfaint,blue >> $ps
psxy -R -J -O -K chicks.txt -S+4i -Wfaint,red >> $ps
psxy -R -J -O chicks.txt -Sc0.1i -Gyellow -Wthin >> $ps