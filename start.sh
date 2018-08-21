#!/bin/bash

# Put any tasks you would like to have carried
# out when the container is first created here

# Set the root passwd - grep docker logs for it
MRFISHY_PASSWORD=`pwgen -c -n -1 12`
echo "mrfishy:$MRFISHY_PASSWORD" | chpasswd
echo "mrfishy login password: $MRFISHY_PASSWORD"
