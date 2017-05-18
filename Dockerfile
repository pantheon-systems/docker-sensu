FROM quay.io/getpantheon/debian:jessie

# pass in via "--build-arg SENSU_VERSION=..."
ARG SENSU_VERSION

# TODO: after 2017-05-17 switch the URL from: "https://sensu.global.ssl.fastly.net/apt" to "https://repositories.sensuapp.org/apt"
RUN apt-get update -y \
  && apt-get install -y \
    wget \
    apt-transport-https \
    build-essential \
  && wget -q https://sensu.global.ssl.fastly.net/apt/pubkey.gpg -O- | apt-key add - \
  && echo "deb     https://sensu.global.ssl.fastly.net/apt jessie main" > /etc/apt/sources.list.d/sensu.list \
  && apt-get update -y \
  && apt-get install -y \
    sensu=${SENSU_VERSION} \
  && apt-get -y autoremove \
  && apt-get -y clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/*
