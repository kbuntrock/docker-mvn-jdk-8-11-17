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

#RUN mvn --version
# installed maven 3 in /usr/share/java/maven-3

ENV MAVEN_4_VERSION=4.0.0-rc-5
ENV MAVEN_4_URL=https://dlcdn.apache.org/maven/maven-4/${MAVEN_4_VERSION}/binaries/apache-maven-${MAVEN_4_VERSION}-bin.tar.gz
RUN wget "$MAVEN_4_URL" && \
    tar -xvzf apache-maven-${MAVEN_4_VERSION}-bin.tar.gz && \
    mv apache-maven-${MAVEN_4_VERSION} /usr/share/java/maven-4 && \
    rm -r apache-maven-${MAVEN_4_VERSION}-bin.tar.gz

# installed maven 4 in /usr/share/java/maven-4
# RUN /usr/share/java/maven-4/bin/mvn --version

ENV GHR_VERSION=0.17.0
ENV GHR_URL=https://github.com/tcnksm/ghr/releases/download/v${GHR_VERSION}/ghr_v${GHR_VERSION}_linux_amd64.tar.gz
RUN wget "$GHR_URL" && \
	tar xzf ghr_v${GHR_VERSION}_linux_amd64.tar.gz && \
	mv ghr_v${GHR_VERSION}_linux_amd64/ghr /usr/bin/ghr && \
	rm -r ghr_v${GHR_VERSION}_linux_amd64.tar.gz ghr_v${GHR_VERSION}_linux_amd64/

# To check if ghr installation is ok
#RUN ghr

# How to switch from maven versions :
# RUN mvn --version
# RUN ln -sf /usr/share/java/maven-4/bin/mvn /usr/bin/mvn
# RUN mvn --version
# RUN ln -sf /usr/share/java/maven-3/bin/mvn /usr/bin/mvn
# RUN mvn --version