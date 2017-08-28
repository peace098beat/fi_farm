#!/bin/bash
# upload metrics and photos.
# this script check updates by AWS IoT shadow and replace source if the new source version is arrived
base_dir="/opt/fi_farm"
data_dir="${base_dir}/data"
photo_dir="${data_dir}/photos/"


# check environment variables
if [ ! -e ${base_dir} ]; then
  echo "no env file"
  exit 1
else
  echo "yes env"
fi


# check environment variables
if [ ! -e ${base_dir}/privatekey ]; then
  echo "no env file"
  exit 1
fi
source ${base_dir}/privatekey


# TEST
if [ -z "${S3_BUCKET+x}" ] ; then
  echo "environment variable S3_BUCKET is requierd"
  exit 1
fi
if [ -z "${AWS_REGION+x}" ] ; then
  echo "environment variable AWS_REGION is requierd"
  exit 1
fi



# Take Photo
for img in `find $photo_dir -type f -name "*.jpg"`
do
  fname=`basename $img`
  y=`echo $fname | cut -d "-" -f1`
  m=`echo $fname | cut -d "-" -f2`
  d=`echo $fname | cut -d "-" -f3`
  echo "upload to s3://${S3_BUCKET}/${y}/${m}/${d}/$fname"
  aws s3 cp $img s3://${S3_BUCKET}/${y}/${m}/${d}/$fname &> /dev/null
  rm -f $img &> /dev/null
done
