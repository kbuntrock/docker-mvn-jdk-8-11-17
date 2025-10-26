# A docker image designed to build maven projects with jdk 8, 11, 17 and 21.
FROM alpine:latest
LABEL org.opencontainers.image.authors="Kévin Buntrock"

# --------------------------------------------
# --- Part needed for testing packages -------
# --------------------------------------------
#RUN cat /etc/apk/repositories

# Needed for openjdk24. Can surely be removed later
RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

#RUN cat /etc/apk/repositories
# --------------------------------------------
# --- End Part needed for testing packages ---
# --------------------------------------------

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
	openjdk21 \
    openjdk25@testing

RUN mkdir -p /root/.m2
COPY toolchains.xml /root/.m2/toolchains.xml

ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk
ENV JAVA8_HOME=/usr/lib/jvm/java-8-openjdk
ENV JAVA11_HOME=/usr/lib/jvm/java-11-openjdk
ENV JAVA17_HOME=/usr/lib/jvm/java-17-openjdk
ENV JAVA21_HOME=/usr/lib/jvm/java-21-openjdk
ENV JAVA25_HOME=/usr/lib/jvm/java-25-openjdk

#RUN ls /usr/lib/jvm/java-25-openjdk
