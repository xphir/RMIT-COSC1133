#!/bin/bash

# Put any tasks you would like to have carried
# out when the container is first created here
/etc/init.d/ssh start
/etc/init.d/nginx start

#keep container open/running
echo "root:docker" | chpasswd
echo "mrfishy:password" | chpasswd

while true; do sleep 1000; done