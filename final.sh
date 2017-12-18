echo -n $(date +(%H:%M:%S));echo " OpenStack Performance testing: Start"

# get non-root username
user=`who`
echo $user |cut -d ' ' -f 1 >> user.log
USER=$(cat user.log)
rm -rf user.log
TIMEDATE=$(date +%m-%d-%y)

# make output folder
mkdir ~/rally-result

# activate rally and use deployment
. /home/"$USER"/rally/bin/activate
rally deployment use rally-deployment
cd task

# test
rally task start service_task.yaml --task-args-file testing_arguments.yaml
rally task report --out ~/rally-result/service_test.html --open 
rally task start launch_instance.yaml --task-args-file launch_arguments.yaml
rally task report --out ~/rally-result/launch_test.html --open

# move report to home for "scp"
cp -rf ~/rally-result /home/"$USER"/
echo -n $(date +(%H:%M:%S));echo " OpenStack Performance testing: Finish"