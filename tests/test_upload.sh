#!/bin/bash
set -Ce

fname=$(basename $0)

echo "[$fname][$(whoami)]"

# Upload
. /home/pi/fi_farm/privatekey

# AWS S3 Access Test
aws s3 ls 
