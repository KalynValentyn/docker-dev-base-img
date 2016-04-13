FROM ubuntu:14.04
MAINTAINER Kalyn Valentyn <valentyn.kalyn@litslink.com>

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

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

# add default user 
RUN useradd -m -s /bin/bash default
RUN chgrp -R default /usr/local
RUN find /usr/local -type d | xargs chmod g+w

# make sudo nopasswd
RUN echo "default ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/default
RUN chmod 0440 /etc/sudoers.d/default

RUN cp -R /root/.nvm /home/default/
RUN chown -R default:default /home/default/

# set default user env
ENV     HOME /home/default
USER    default

RUN cd /tmp &&\
  wget -O ruby-install-0.6.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.6.0.tar.gz &&\
  tar -xzvf ruby-install-0.6.0.tar.gz &&\
  cd ruby-install-0.6.0/ &&\
  make install

# Install MRI Ruby
RUN ruby-install ruby 2.3.0

# Add Ruby binaries to $PATH
ENV PATH /opt/rubies/ruby-2.3.0/bin:$PATH

# Add options to gemrc
RUN echo "install: --no-document\nupdate: --no-document" > ~/.gemrc

# Install bundler
RUN gem install bundler

# install npm
RUN sudo apt-get install -y npm
#install and update nodejs
RUN npm cache clean -f && npm install -g n && n stable

RUN mkdir /home/default/app
WORKDIR /home/default/app
