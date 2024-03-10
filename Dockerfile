FROM ubuntu:latest as base
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install -y build-essential git curl sudo ansible

# add sudo user with no password
RUN useradd -ms /bin/bash joey && \
    usermod -aG sudo joey
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER joey
WORKDIR /home/joey

FROM base
COPY . /home
RUN ansible-playbook ../main.yml --tags "core,dotfiles,zsh,tmux,nvim"
ENTRYPOINT ["/bin/zsh"]
