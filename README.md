# Performance testing with OpenStack Rally

ในส่วนนี้จะเป็นการสั่งการทำงานด้วย Shell script ที่สร้างขึ้นโดยใช้คำสั่งของ Rally ประกอบการทำงานพร้อมทั้งแสดง Output เป็น HTML file เพื่อนำข้อมูลที่ได้มาใช้ในการ Benchmark Hardware ต่อไป

## Getting Started

เครื่องที่จะใช้จะต้องติดตั้ง OpenStack และ Rally แล้ว
การติดตั้ง Rally อย่างง่าย สามารถศึกษาได้จาก [ที่นี่](http://rally.readthedocs.io/en/0.10.0/install_and_upgrade/index.html)

### Prerequisites

ให้ผู้ใช้สร้าง rc file เพื่อกำหนด deployment เพื่อใช้ในการ performence testing

หลังจากที่ clone project นี้แล้ว ให้ท่านทำการเปิดไฟล์ first_time_setup.sh แล้วแก้ไข Script โดยให้แก้ rc file จาก openrc เป็น file ที่ท่านใช้งานเช่น
```
source ~/dummyrc
```
และแก้ไข path ที่ใช้ Activate rally บนไฟล์ first_time_setup.sh และ final.sh ตัวอย่างเช่น
```
. [ต้นทางของpath]/rally/bin/activate
```
จากนั้นแก้ไข arguments ต่างๆ โดยแก้ไขที่ tasks/testing_arguments.yaml และ tasks/launch_arguments.yaml โดยใส่ชื่อ images flavor ที่ใช้ในการประกอบการทดสอบ รวมถึงกำหนดจำนวนรอบและจำนวนโหลดในการทดสอบ เช่น

```
---
  images: #list image name 
    - Ubuntu1604
    - Windows
  flavors: # list flavor name
    - nc1.B
  resize_flavors: # dict flavor name , resized flavor name
    - nc1.B: ['nc1.C']
  times: 10 #  amount of test (round)
  concurrency: 2 # amount of load to test
```

## Running the test

ให้ผู้ใช้เข้า folder ที่ทำการ clone จากนั้นให้ run script ที่ชื่อว่า [first_time_setup.sh](https://github.com/KoutaCS/rally_test/blob/staging/first_time_setup.sh) หากทำการ run ครั้งแรก เพื่อทำการกำหนด deployment เพื่อทำการ performance testing หากทำการทดสอบครั้งถัดๆไปให้ใช้ [performance_testing.sh](https://github.com/KoutaCS/rally_test/blob/staging/performance_testing.sh) แทน

### Single Task
หากต้องการ Test เพียง Task เดียว สามารถใช้งานได้โดยกำหนด Task file และ Argument file ที่ต้องการจะ Test จากนั้นให้ใช้คำสั่ง
```
rally task start [task file] --task-args-file [args file]
```
เมื่อ Test เสร็จแล้ว ให้ใช้คำสั่งเพื่อทำการจัดทำผลการทดสอบ
```
rally task report --out [file name].html --open
```

## Result

ผลลัพธ์จะอยู่ใน folder หนึ่งที่ชื่อ rally-result ให้ผู้ใช้ทำการ scp เพื่อ copy folder ที่ชื่อ rally-result เข้าเครื่องของผู้ใช้ แล้วทำการเปิดไฟล์เพื่อดู Output

## Useful link
* [การสร้าง Scenario](http://rally.readthedocs.io/en/0.10.0/plugins/implementation/scenario_plugin.html)
* [การสร้าง Task](http://rally.readthedocs.io/en/0.10.0/quick_start/tutorial/step_2_input_task_format.html)
* [OpenStack Rally's Document](http://rally.readthedocs.io)

## Repositories
* [Scenario repository](https://github.com/KoutaCS/nipa.cloud_scenario)
* [Task repositoty](https://github.com/KoutaCS/rally_test)

## Author
**Chitsanupong Boorana** - *Internship student* - [Nipa.Cloud](https://www.nipa.cloud/)
