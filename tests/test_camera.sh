#!/bin/bash
set -Ce

fname=$(basename $0)

echo "[$fname][$(date)] Im $(whoami)"

img=$(date +"%Y-%m-%d-%H%M%S").jpg
imgpath='/home/pi/fi_farm/tests/data/'$img

raspistill -w 60 -h 60 -o $imgpath

if [ ! -e $imgpath ];then
 echo [$fname][TEST]Fail!! raspistll.
else
 echo [$fname][TEST]Success!! exists $(basename $imgpath)
fi
 


