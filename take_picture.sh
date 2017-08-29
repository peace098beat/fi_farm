#!/bin/sh
set -Ce




photo_dir="/home/pi/fi_farm/data/photos"

file_name=$(date +"%Y-%m-%d-%H%M%S").jpg

echo "[$(basename $0)]take_picture :  ${photo_dir}/${file_name}"
raspistill -w 1280 -h 720 -o ${photo_dir}/${file_name}



