FROM debian

LABEL maintainer="Elliot Schot <s3530160@student.rmit.edu.au>"

ARG LAST_4_DIGIT_STUDENT_NUMBER=0160

ARG FISH_SHELL_LINK="https://github.com/fish-shell/fish-shell/releases/download/2.7.1/fish-2.7.1.tar.gz"
ARG BERRYCONDA_LINK="https://github.com/jjhelmus/berryconda/releases/download/v2.0.0/Berryconda3-2.0.0-Linux-armv7l.sh"

############## build stage ##############
RUN \
	echo "**** install build packages ****" && \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
	#packages requested
	gcc \
	g++ \
	vim \
	vim-gtk3 \
	nginx \
	openssh-server \
	pwgen \
	#packages for compling from source
	make \
	cmake \
	build-essential \
	ncurses-dev \
	libncurses5-dev \
	gettext \
	mktemp \
	autoconf \
	supervisor \
	fish &&\
	#Create mrFishy
	echo "**** create mrfishy ****" && \
	MRFISHY_PASSWORD=`pwgen -c -n -1 12` && \
	useradd -m -s /usr/local/bin/fish -d /home/fishy -c "Fish Fish" -G root mrfishy  && \
	echo "password" | passwd mrfishy --stdin && \
	#SSH config settings
	echo "**** disable ssh root login ****" && \
 	sed -i 's/#\?\(PermitRootLogin\s*\).*$/\1 no/' /etc/ssh/sshd_config &&\
	#Installing berryconda
	echo "**** installing berryconda ****" && \
	curl -o /tmp/berryconda.sh -L "${BERRYCONDA_LINK}" && \
	chmod +x /tmp/berryconda.sh &&\
	./tmp/berryconda.sh -b -p /usr/bin/berryconda3 &&\
	echo "PATH=/usr/bin/berryconda3/bin:$PATH" > /etc/profile.d/berryconda.sh && \
	#installing fish shell
	#echo "**** compling fish from source ****" && \
	#curl -o /tmp/fish.tar.gz -L "${FISH_SHELL_LINK}" && \
	#mkdir /tmp/fishbuild &&\
	#tar -xzf /tmp/fish.tar.gz --directory /tmp/fishbuild && \
	#cd /tmp/fishbuild/fish-2.7.1 && \
	#./configure; make; make install &&\
	#cleanup install
	echo "**** cleanup ****" && \
	apt-get clean && \
	rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

EXPOSE 80
EXPOSE 22

# Called on first run of docker - will run supervisor
ADD start.sh /start.sh
RUN chmod 0755 /start.sh

CMD /start.sh

#Script sets the password for mrfishy and prints it to screen - use [docker logs <container name> | grep 'root login password']

#cmake fishshell install
#curl -o /tmp/fish.zip -L "https://github.com/fish-shell/fish-shell/archive/master.zip" &&\
#unzip /tmp/fish.zip -d /tmp/ && \
#mkdir /tmp/fish-shell-master/build &&\
#cd /tmp/fish-shell-master/build && \
#cmake .. && \
#make && \
#make install && \

#echo "password" | passwd mrfishy --stdin

#curl -o /tmp/fish.tar.gz -L "${FISH_SHELL_LINK}" && \
#mkdir /tmp/fishbuild &&\
#tar -xzf /tmp/fish.tar.gz --directory /tmp/fishbuild && \
#cd /tmp/fishbuild/fish-2.7.1 && \
#./configure; make; make install &&\
#cleanup install

#MRFISHY_PASSWORD=`pwgen -c -n -1 12` &&\
#echo "mrfishy:$MRFISHY_PASSWORD" | chpasswd &&\