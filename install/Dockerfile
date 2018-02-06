# Ubuntu with personalized setup
FROM ubuntu:latest
MAINTAINER Thomas Goldbrunner <thomas.goldbrunner@posteo.de>

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/folixg/dot-files.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0"

# install ansible
RUN apt-get update \
&& apt-get install -y software-properties-common \
&& apt-add-repository -y ppa:ansible/ansible \
&& apt-get update \
&& apt-get install -y ansible git sudo

# create user
RUN useradd --create-home --shell /usr/bin/zsh folix
RUN adduser folix sudo
RUN echo "folix ALL=(ALL) NOPASSWD:ALL" | tee -a /etc/sudoers
USER folix

# installation using ansible
RUN git clone https://github.com/folixg/dot-files.git /home/folix/dot-files 
RUN cd /home/folix/dot-files/install/ansible \
    && ansible-playbook -i inventory docker.yml

# cleanup
USER root
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# switch user
USER folix
WORKDIR /home/folix

# start zsh
ENTRYPOINT /usr/bin/zsh
