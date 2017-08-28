#!/bin/bash
# install.sh

base_dir="/opt/fi_farm"
data_dir="${base_dir}/data"
photo_dir="${data_dir}/photos/"


# ルートディレクトリの削除
if [ ! -e ${base_dir} ]; then
  echo "no ${base_dir}"
else
  echo "exists ${base_dir}"
  sudo rm -rf ${base_dir}
fi


# UPDATE
# sudo apt-get update -y
# sudo apt-get upgrade -y

# # 必要なソフトのインストール
# sudo apt-get install git -y
# sudo apt-get install postfix -y
# sudo apt-get install python2.7-dev -y

# # AWS CLIのインストール
# sudo pip install awscli
# aws --version

# Source Code のダウンロード
GIT_REPO="https://github.com/peace098beat/fi_farm.git"
sudo git clone ${GIT_REPO} ${base_dir}

# mkdir
sudo mkdir -p ${photo_dir}

# Cronの開始
crontab ${base_dir}/crontab
sudo /etc/init.d/cron restart
crontab -l

# 変数展開
PRIVATE_KEY="${base_dir}/privatekey"
sudo cp ${PRIVATE_KEY}.org ${PRIVATE_KEY}

