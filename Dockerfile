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
    wget                   \
    sudo                   \
    git                    \
    curl                   \
    build-essential        \
    imagemagick            \
    libpq-dev              \ 
    autoconf               \
    libreadline-dev        \
    libssl-dev             \
    libxml2-dev            \
    libxslt-dev            \
    zlib1g-dev             \
    libbz2-dev

RUN echo "# Install rvm" && \
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
    curl https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer | bash -s stable --ruby && \
    echo "source /etc/profile.d/rvm.sh" >> ~/.bashrc && \
    /bin/bash -l -c "gem install bundler"  

# install npm
RUN apt-get install -y npm
#install and update nodejs
RUN npm cache clean -f && npm install -g n && n 5.8.0

RUN echo "deb http://security.ubuntu.com/ubuntu lucid-security main" >> /etc/apt/sources.list
RUN echo "deb http://cz.archive.ubuntu.com/ubuntu lucid main" >> /etc/apt/sources.list

RUN apt-get update

RUN apt-get install graphviz -y

RUN mkdir /var/app
WORKDIR /var/app
