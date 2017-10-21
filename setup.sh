#!/bin/bash
set -Ceu

# ====================================================================
# Check Option 
# ====================================================================
CMDNAME="basename $0"
FLG_TEST="FALSE"
while getopts t OPT
do
  case $OPT in
	"t" ) FLG_TEST="TRUE" ;;
	 *  ) echo "Usage ${CMDNAME} [-t]" 1>&2
		exit 1 ;;
  esac
done

if [ "$FLG_TEST" = "TRUE" ]; then
  echo "[ INFO ] TEST MODE"
fi


# ====================================================================
# Check Bash
# ====================================================================
if [ $SHELL == "/bin/bash" ];then
  echo "[ OK ]Im : bash"
else
  echo "[ NG ]Im ${SHELL} . Not /bin/bash"
  echo "[Warning] Need Bash.  Exit.."
  exit 1
fi

# ====================================================================
# Check User
# ====================================================================
if [ $(whoami) == 'root' ];then
    echo "[ NG ]Fail.. Im root.."
    echo "[ NG ]Please Input => bash setup.sh"
    echo "[ NG ]Not use sudo .."
    exit 1
else
    echo "[ OK ]Im $(whoami)..  not root."
fi

# ====================================================================
# Workspace
# ====================================================================
SCRIPT_DIR=$(cd $(dirname $0);pwd)
echo "[ INFO ] SCRIPT_DIR ${SCRIPT_DIR}"

BASE_DIR=${HOME}/fi_farm
DATA_DIR=${BASE_DIR}/data
PHOTOS_DIR=${DATA_DIR}/photos
echo "[ INFO ] BASE_DIR ${BASE_DIR}"


# ====================================================================
# Install Sub Package
# ====================================================================
if [ "$FLG_TEST" = "FALSE" ]; then

sudo apt-get update -y

sudo apt-get upgrade -y

sudo apt-get install git -y
sudo apt-get install postfix -y
sudo apt-get install python2.7-dev python-pip -y

# AWS CLI
sudo pip install awscli

fi

# ====================================================================
# AWS CLI
# ====================================================================
if type aws > /dev/null 2>&1;then
  echo "[ OK ]Exists aws command."
  echo "[ OK ]$(aws --version)"
else
  echo "[ NG ]Fail! Uninstall aws command."
  exit 1
fi

# ====================================================================
# Private key
# ====================================================================
PRIVATE_KEY="${BASE_DIR}/privatekey"
. ${PRIVATE_KEY}

if [ "$FLG_TEST" = "FALSE" ]; then

aws configure set aws_access_key_id ${AWS_ACCESS_KEY}
aws configure set aws_secret_access_key ${AWS_SECRET_KEY}
aws configure set region ${AWS_REGION}
aws configure set default.region ${AWS_REGION}
echo "[ INFO ] configure aws" 

fi

# ====================================================================
# Source Code のダウンロード
# ====================================================================
if [ ! -e ${BASE_DIR} ];then
  git clone ${GIT_REPO} ${BASE_DIR}
  echo "[ OK ]Download Source Code from ${GIT_REPO} to ${BASE_DIR}"
fi

# ====================================================================
# mkdir
# ====================================================================
mkdir -p ${PHOTOS_DIR}
mkdir -p ${BASE_DIR}/logs

# ====================================================================
# chmod
# ====================================================================
chmod -R 700 ${BASE_DIR}
chmod -R 700 ${BASE_DIR}/*
chmod -R 700 ${DATA_DIR}

# ====================================================================
# setup cron
# ====================================================================
sudo cp ${BASE_DIR}/etc/fifarm-cron /etc/cron.d/
sudo chmod 644 /etc/cron.d/fifarm-cron
sudo /etc/init.d/cron restart


# ====================================================================

echo "[ OK ] Finish! Setup!"




