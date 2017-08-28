#!/bin/bash
# upload metrics and photos.
# this script check updates by AWS IoT shadow and replace source if the new source version is arrived
base_dir="/opt/fi_farm"
data_dir="${base_dir}/data"
photo_dir="${data_dir}/photos/"


# check environment variables
if [ ! -e ${base_dir} ]; then
  echo "nothing  ${base_dir}. exit.."
  exit 1
else
  echo "exist ${base_dir}"
fi


# check environment variables
if [ ! -e ${base_dir}/privatekey ]; then
  echo "no ${base_dir}/privatekey"
  exit 1
fi

# source
. ${base_dir}/privatekey


# TEST
if [ -z "${S3_BUCKET+x}" ] ; then
  echo "environment variable S3_BUCKET is requierd"
  exit 1
fi
if [ -z "${AWS_REGION+x}" ] ; then
  echo "environment variable AWS_REGION is requierd"
  exit 1
fi

aws configure set aws_access_key_id ${AWS_ACCESS_KEY}
aws configure set aws_secret_access_key ${AWS_SECRET_KEY}
aws configure set region ${AWS_REGION}
aws configure set default.region ${AWS_REGION}

echo "who am i ? :"
whoami

# Take Photo
for img in `find $photo_dir -type f -name "*.jpg"`
do
  fname=`basename $img`
  y=`echo $fname | cut -d "-" -f1`
  m=`echo $fname | cut -d "-" -f2`
  d=`echo $fname | cut -d "-" -f3`
  echo "img is $img"
  echo "upload to s3://${S3_BUCKET}/${y}/${m}/${d}/$fname"
  aws s3 cp $img s3://${S3_BUCKET}/${y}/${m}/${d}/$fname 
  rm -f $img 
done
