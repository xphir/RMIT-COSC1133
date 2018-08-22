docker-a1
==========

A simple docker container for COSC1133 assignment 01

mrfishy password is 'docker'

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


To run the container localy do:
note: if the github repo is private you need to git clone/pull 

```
git clone git@github.com:rmit-s3530160-elliot-schot/COSC1133.git
cd COSC1133/
docker build -t s3530160/assignment .
docker run -d -p 20160:22 -p 50160:80 --name assignment s3530160/assignment
```

to view running containers (and to see all current containers)
```
docker ps
docker ps -a
```

To close and delete the container
```
docker stop assignment
docker rm assignment
```
-----------

Elliot Schot (s3530160@student.rmit.edu.au

21/08/2018