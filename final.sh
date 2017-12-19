#!/bin/bash

# make output folder
mkdir ~/rally-result

# activate rally and use deployment
. /openstack/venvs/rally-16.0.5/bin/activate
rally deployment use rally-deployment
cd task

# test
rally task start service_task.yaml --task-args-file launch_arguments.yaml
rally task report --out ~/rally-result/service_test.html --open 
rally task start launch_instance.yaml --task-args-file launch_arguments.yaml
rally task report --out ~/rally-result/launch_test.html --open