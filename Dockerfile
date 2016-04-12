FROM ubuntu:14.04
MAINTAINER Kalyn Valentyn <valentyn.kalyn@litslink.com>

# set UTF-8 locale
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# install some system libs
RUN apt-get update -qq -y
RUN apt-get install -qq -y \
    sudo                   \
    git                    \
    curl                   \
    build-essential        \
    autoconf               \
    libreadline-dev        \
    libssl-dev             \
    libxml2-dev            \
    libxslt-dev            \
    zlib1g-dev             \
    libbz2-dev

# install npm and update nodejs
RUN apt-get install -y npm
RUN npm cache clean -f && npm install -g n && n stable

# add default user 
RUN useradd -m -s /bin/bash default
RUN chgrp -R default /usr/local
RUN find /usr/local -type d | xargs chmod g+w

# make sudo nopasswd
RUN echo "default ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/default
RUN chmod 0440 /etc/sudoers.d/default

# set default user env
ENV     HOME /home/default
USER    default

# install RVM and stable version of ruby
RUN  cd /home/default \
  && gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
  && \curl -sSL https://get.rvm.io | bash -s stable --ruby \
  && RUN echo "source $HOME/.rvm/scripts/rvm" >> ~/.bash_profile

RUN mkdir /home/default/app
WORKDIR /home/default/app
