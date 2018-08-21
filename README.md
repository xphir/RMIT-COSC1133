docker-a1
==========

A simple docker container for COSC1133 assignment 01

To build the image do:

```
docker build -t s3530160/ssh git://github.com/rmit-s3530160-elliot-schot/COSC1133
```

To run a container do:

```
docker run -it -p 100:80 -p 20160:22 -p 50160:80 --name assignment01 s3530160/ssh
```

To log into your container do:

```
ssh -x myfishy@localhost -p 20160
```

Default password will appear in docker logs:

```
docker logs <container name> | grep 'mrfishy login password'
docker logs assignment01 | grep 'mrfishy login password'
```

If the github repo is private you need to git clone/pull

```
git clone git@github.com:rmit-s3530160-elliot-schot/COSC1133.git
cd COSC1133/
docker build -t s3530160/ssh .
docker run -it -p 20160:22 -p 50160:80 --name assignment01 s3530160/ssh
```

-----------

Elliot Schot (s3530160@student.rmit.edu.au

21/08/2018