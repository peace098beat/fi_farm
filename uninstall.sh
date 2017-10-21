#!/bin/bash
set -Ceu

echo "[ INFO ] Uninstall fifarm"


sudo rm /etc/cron.d/fifarm-cron
sudo /etc/init.d/cron restart

