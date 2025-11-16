# A docker image designed to build maven projects with jdk 8, 11, 17 and 21.
FROM alpine:latest
LABEL org.opencontainers.image.authors="Kévin Buntrock"

# --------------------------------------------
# --- Part needed for testing packages -------
# --------------------------------------------
#RUN cat /etc/apk/repositories

# Needed for openjdk24. Can surely be removed later
#RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

#RUN cat /etc/apk/repositories
# --------------------------------------------
# --- End Part needed for testing packages ---
# --------------------------------------------

RUN wget -O /etc/apk/keys/adoptium.rsa.pub https://packages.adoptium.net/artifactory/api/security/keypair/public/repositories/apk
RUN echo 'https://packages.adoptium.net/artifactory/apk/alpine/main' >> /etc/apk/repositories

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
    temurin-25-jdk

RUN mkdir -p /root/.m2
COPY toolchains.xml /root/.m2/toolchains.xml

ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk
ENV JAVA8_HOME=/usr/lib/jvm/java-8-openjdk
ENV JAVA11_HOME=/usr/lib/jvm/java-11-openjdk
ENV JAVA17_HOME=/usr/lib/jvm/java-17-openjdk
ENV JAVA21_HOME=/usr/lib/jvm/java-21-openjdk
ENV JAVA25_HOME=/usr/lib/jvm/java-25-temurin

#RUN ls /usr/lib/jvm/java-25-temurin

ENV GHR_VERSION=0.17.0
ENV GHR_URL=https://github.com/tcnksm/ghr/releases/download/v${GHR_VERSION}/ghr_v${GHR_VERSION}_linux_amd64.tar.gz
RUN wget "$GHR_URL" && \
	tar xzf ghr_v${GHR_VERSION}_linux_amd64.tar.gz && \
	mv ghr_v${GHR_VERSION}_linux_amd64/ghr /usr/bin/ghr && \
	rm -r ghr_v${GHR_VERSION}_linux_amd64.tar.gz ghr_v${GHR_VERSION}_linux_amd64/

# To check if ghr installation is ok
#RUN ghr
