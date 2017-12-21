#!/bin/bash

. /openstack/venvs/rally-16.0.5/bin/activate

. ~/openrc
rally deployment create --fromenv --name rally-deployment

mkdir ~/.rally
git clone https://github.com/KoutaCS/nipa.cloud_scenario ~/.rally/plugins

. performance_testing.sh