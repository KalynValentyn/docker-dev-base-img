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

# set default user env
ENV     HOME /home/default
USER    default
ADD bashrc /home/default/.bashrc

# install NVM and set default node
RUN echo "# Install nvm" && \
    cd /home/default/ && \
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.25.4/install.sh | bash && \
    /bin/bash -l -c "nvm install stable && nvm use stable default"

RUN echo "# Install rvm" && \
    cd /home/default/ && \
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
    curl https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer | bash -s stable --ruby && \
    sudo echo "source /etc/profile.d/rvm.sh" >> ~/.bashrc && \
    /bin/bash -l -c "gem install bundler" 

RUN mkdir /home/default/app
WORKDIR /home/default/app
