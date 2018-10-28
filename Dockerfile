FROM ubuntu:trusty

RUN adduser moses
COPY .git /home/moses/.git

RUN echo "moses" > /etc/hostname
RUN echo "moses ALL=NOPASSWD: ALL" > /etc/sudoers.d/moses
WORKDIR /home/mbe/

#RUN apt-get -y install wget unzip
COPY . /home/moses/
RUN env sh /home/moses/setup.sh

USER moses
ENTRYPOINT bash -i
