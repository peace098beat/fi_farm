#!/bin/bash
set -Ceu

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
base_dir="/home/pi/fi_farm"
data_dir="${base_dir}/data"
photo_dir="${data_dir}/photos/"

# ====================================================================
# Install Sub Package
# ====================================================================
# 必要なソフトのインストール
sudo apt-get update -y
sudo apt-get upgrade -y

# 必要なソフトのインストール
sudo apt-get install git -y
sudo apt-get install postfix -y
sudo apt-get install python2.7-dev python-pip -y

# AWS CLIのインストール
sudo pip install awscli

if [ type aws > /dev/null 2>&1 ];then
  echo "[ OK ]Exists aws command."
  echo "[ OK ]$(aws --version)"
else
  echo "[ NG ]Fail! Uninstall aws command."
fi


# Source Code のダウンロード
GIT_REPO="https://github.com/peace098beat/fi_farm.git"
git clone ${GIT_REPO} ${base_dir}

# mkdir
mkdir -p ${photo_dir}

# chmod
chmod -R 700 ${base_dir}
chmod -R 700 ${base_dir}/*
# chmod
chmod -R 700 ${data_dir}
# Cronの開始
chmod 700 ${base_dir}/crontab*

# setup cron
crontab ${base_dir}/crontab
sudo /etc/init.d/cron restart

# 変数展開
PRIVATE_KEY="${base_dir}/privatekey"
cp -n ${PRIVATE_KEY}.org ${PRIVATE_KEY}

echo "[ OK ]Setup Finish!!"
