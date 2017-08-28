# fi_farm

ラズベリーパイで畑を観察する.


# 使い方

ユーザフォルダに以下のシェルスクリプトを作成し実行.

```
#!/bin/bash
# install.sh

base_dir="/opt/fi_farm"
data_dir="${base_dir}/data"
photo_dir="${data_dir}/photos/"


# check environment variables
if [ ! -e ${base_dir} ]; then
  echo "no ${base_dir}"
  exit 1
else
  echo "exists ${base_dir}"
  rm -rf ${base_dir}
fi

# Install aws
sudo apt-get update -y
sudo apt-get upgrade -y

sudo apt-get install git -y
sudo apt-get install python2.7-dev -y

# AWS CLIのインストール
sudo pip install awscli
aws --version

# Source Code のダウンロード
GIT_REPO="https://github.com/peace098beat/fi_farm.git"
sudo git clone ${GIT_REPO} ${base_dir}

# Cronの開始
crontab ${base_dir}/crontab

# 変数展開
source ${base_dir}/privatekey

PRIVATE_KEY="${base_dir}/privatekey"
cp ${PRIVATE_KEY}.org ${PRIVATE_KEY}
```
