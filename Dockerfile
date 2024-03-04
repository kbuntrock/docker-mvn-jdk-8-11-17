# A docker image designed to build maven projects with jdk 8, 11, 17 and 21.
FROM alpine:latest
MAINTAINER Kévin Buntrock

RUN apk update && apk add \
    ca-certificates \
    git \
	openssh \
	bash \
    maven \
    vim \
	openjdk8 \
	openjdk11 \
	openjdk17 \
	openjdk21 

RUN mkdir -p /root/.m2
COPY toolchains.xml /root/.m2/toolchains.xml

ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk
ENV JAVA8_HOME=/usr/lib/jvm/java-8-openjdk
ENV JAVA11_HOME=/usr/lib/jvm/java-11-openjdk
ENV JAVA17_HOME=/usr/lib/jvm/java-17-openjdk
ENV JAVA21_HOME=/usr/lib/jvm/java-21-openjdk
