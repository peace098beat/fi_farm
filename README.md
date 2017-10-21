# fi_farm

ラズベリーパイで畑を観察する.


# 使い方

githubからfi_farmリポジトリをダウンロードし、setupスクリプトを　実行する.

```
git clone https://github.com/peace098beat/fi_farm.git ~/fi_farm
cd ~/fi_farm
bash setup.sh
```

そのご``~/fi_farm/private``がでてきているので、awsのIAMのIDとパスワードを変更する。

以上.

# ログの確認
ログは``~/cron.log``に格納されている.

# git
```
git pull origin master

git push -u origin master
```
