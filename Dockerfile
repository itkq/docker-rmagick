FROM ubuntu:14.04

RUN apt-get update -qq
RUN apt-get install -y build-essential wget curl git git-core

# source: https://github.com/cookpad/janiConverter/blob/master/Dockerfile

# imagemagick
RUN apt-get install -y imagemagick

# ruby & gem dependencies
RUN apt-get -y install \
    libcurl4-openssl-dev \
    libreadline-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    libyaml-dev \
    zlib1g-dev && \
    curl -O http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.3.tar.gz && \
    tar -zxvf ruby-2.1.3.tar.gz && \
    cd ruby-2.1.3 && \
    ./configure --disable-install-doc && \
    make -j 4 && \
    make install && \
    cd .. && \
    rm -r ruby-2.1.3 ruby-2.1.3.tar.gz && \
    echo 'gem: --no-document' > /usr/local/etc/gemrc

# dependencies to install rmagick gem
RUN apt-get -y install libmagickcore-dev libmagickwand-dev

RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc
RUN gem update --system
RUN gem update
RUN gem install bundler
RUN gem install rmagick
