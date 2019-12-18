# Ubuntu with personalized setup
FROM ubuntu:latest
MAINTAINER Thomas Goldbrunner <thomas.goldbrunner@posteo.de>

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/folixg/dot-files.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0"

# copy entry script
COPY start.sh /start.sh

# install ansible
RUN apt-get update \
    && apt-get install -y software-properties-common \
    && apt-add-repository -y ppa:ansible/ansible \
    && apt-get update \
    && apt-get install -y ansible git sudo gosu

# create user
RUN groupadd folix \
    && useradd --create-home --shell /usr/bin/zsh -g folix folix \
    && adduser folix sudo \
    && echo "folix ALL=(ALL) NOPASSWD:ALL" | tee -a /etc/sudoers
USER folix

# installation using ansible
RUN git clone https://github.com/folixg/dot-files.git /home/folix/dot-files \ 
    && cd /home/folix/dot-files/install/ansible \
    && ansible-playbook -i inventory docker.yml \
    && sudo rm -rf /var/lib/apt/lists/*

# cd to user home
WORKDIR /home/folix/workspace

USER root

# start zsh
ENTRYPOINT [ "/start.sh" ]
