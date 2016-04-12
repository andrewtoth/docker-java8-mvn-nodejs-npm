FROM buildpack-deps:jessie-scm

RUN apt-get update && apt-get install build-essential bzip2 -y

##### https://github.com/docker-library/java/blob/6f340724d3bc1f9b4385975c5de6bfe15aac8c85/openjdk-8-jdk/Dockerfile

# A few problems with compiling Java from source:
#  1. Oracle.  Licensing prevents us from redistributing the official JDK.
#  2. Compiling OpenJDK also requires the JDK to be installed, and it gets
#       really hairy.

RUN apt-get update && apt-get install -y unzip && rm -rf /var/lib/apt/lists/*

RUN echo 'deb http://httpredir.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

RUN set -x \
	&& apt-get update \
	&& apt-get install -y \
		openjdk-8-jre \
	&& rm -rf /var/lib/apt/lists/*

##### https://github.com/nodejs/docker-node/blob/d798690bdae91174715ac083e31198674f044b68/0.12/wheezy/Dockerfile

ENV NODE_VERSION 5.9.1
ENV NPM_VERSION 3.7.3

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
	&& tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
	&& rm "node-v$NODE_VERSION-linux-x64.tar.gz" \
	&& npm install -g npm@"$NPM_VERSION" \
	&& npm cache clear
