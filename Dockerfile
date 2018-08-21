FROM debian

LABEL maintainer="Elliot Schot <s3530160@student.rmit.edu.au>"

ARG LAST_4_DIGIT_STUDENT_NUMBER=0160

ARG FISH_SHELL_LINK="https://github.com/fish-shell/fish-shell/releases/download/2.7.1/fish-2.7.1.tar.gz"
ARG BERRYCONDA_LINK="https://github.com/jjhelmus/berryconda/releases/download/v2.0.0/Berryconda3-2.0.0-Linux-armv7l.sh"

############## build stage ##############
RUN \
	echo "Last 4 digits of my student number: ${LAST_4_DIGIT_STUDENT_NUMBER}" &&\
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
	openssh-server\
	#packages for compling from source
	make \
	build-essential \
	ncurses-dev \
	libncurses5-dev \
	gettext \
	autoconf &&\
	#SSH config settings
	echo "**** disable ssh root login ****" && \
	#sed -i 's/#\?\(Port\s*\).*$/\1 20160/' /etc/ssh/sshd_config &&\
	sed -i 's/#\?\(PermitRootLogin\s*\).*$/\1 no/' /etc/ssh/sshd_config &&\
	#Create mrFishy
	echo "**** create mrfishy ****" && \
	useradd -m -s /usr/local/bin/fish -d /home/fishy -c "Fish Fish" mrfishy &&\
	#Installing berryconda
	#echo "**** installing berryconda ****" && \
	#curl -o /tmp/berryconda.sh -L "${BERRYCONDA_LINK}" && \
	#chmod +x /tmp/berryconda.sh &&\
	#./tmp/berryconda.sh -b -p /home/fishy/berryconda3 &&\
	#installing fish shell
	echo "**** compling fish from source ****" && \
	curl -o /tmp/fish.tar.gz -L "${FISH_SHELL_LINK}" && \
	mkdir /tmp/fishbuild &&\
	tar -xzf /tmp/fish.tar.gz --directory /tmp/fishbuild && \
	cd /tmp/fishbuild/fish-2.7.1 && \
	./configure; make; make install &&\
	#cleanup install
	echo "**** cleanup ****" && \
	apt-get clean && \
	rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*
	
EXPOSE 80
EXPOSE 22

#Script sets the password for mrfishy and prints it to screen - use [docker logs <container name> | grep 'root login password']
ADD start.sh /start.sh
RUN chmod 0755 /start.sh
CMD /start.sh