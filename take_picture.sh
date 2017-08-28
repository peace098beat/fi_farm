#!/bin/sh

photo_dir="/opt/fi_farm/data/photos"
file_name=$(date +"%Y-%m-%d-%H%M%S").jpg

echo "take_picture :  ${photo_dir}/${file_name}"
raspistill -v -w 1280 -h 720 -o ${photo_dir}/${file_name}
