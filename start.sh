#!/bin/bash

# Put any tasks you would like to have carried
# out when the container is first created here
echo "mrfishy:cosc1133" | chpasswd
/etc/init.d/ssh start
/etc/init.d/nginx start