FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y build-essential
RUN apt-get install git curl -y
RUN apt-get install sudo -y

RUN apt-get install ansible -y

RUN echo "root:root" | chpasswd
#RUN useradd -ms /bin/bash joey
#RUN usermod -a -G sudo joey
#RUN echo "joey:joey" | chpasswd
#USER joey
RUN addgroup --gid 1000 joey
RUN adduser --gecos joey --uid 1000 --gid 1000 --disabled-password joey
RUN usermod -aG sudo joey
RUN echo "joey:joey" | chpasswd
USER joey
WORKDIR /home/joey

COPY . /home
