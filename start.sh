#!/bin/bash

# Put any tasks you would like to have carried
# out when the container is first created here

#ROOT_PASSWORD=`pwgen -c -n -1 12`
PASSWORD='assignment'
#echo "mrfishy:$PASSWORD" | chpasswd
echo -e "$PASSWORD\n$PASSWORD" | passwd mrfishy
echo "mrfishy login password: $PASSWORD"

/etc/init.d/ssh start
/etc/init.d/nginx start

while true; do sleep 1000; done