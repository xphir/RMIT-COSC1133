#!/bin/bash

# Put any tasks you would like to have carried
# out when the container is first created here
/etc/init.d/ssh start
/etc/init.d/nginx start

#ROOT_PASSWORD=`pwgen -c -n -1 12`
PASSWORD='assignment'
#echo "mrfishy:$PASSWORD" | chpasswd
echo -e "$PASSWORD\n$PASSWORD" | passwd mrfishy
echo "mrfishy login password: $PASSWORD"

while true; do sleep 1000; done