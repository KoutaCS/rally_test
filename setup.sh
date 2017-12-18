#!/bin/bash

echo -n $(date +(%H:%M:%S));echo " Setting environment: Setting"

user=`who`
echo $user |cut -d ' ' -f 1 >> user.log
USER=$(cat user.log)
rm -rf user.log

. /home/"$USER"/rally/bin/activate

. ~/openrc
rally deployment create --fromenv --name rally-deployment

mkdir ~/.rally
cp -R /home/"$USER"/rally/src/rally-jobs/extra ~/.rally
git clone https://github.com/KoutaCS/nipa.cloud_scenario ~/.rally/plugins

echo -n $(date +(%H:%M:%S));echo " Setting environment: Finish"

. final.sh