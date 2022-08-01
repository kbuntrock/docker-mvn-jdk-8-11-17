A docker image designed to build maven projects with jdk 8, 11 and 17.

Useful commands : 

docker build -t maven-toolchain-jdk-8-11-17 .

docker save maven-toolchain-jdk-8-11-17:latest > maven-toolchain-jdk-8-11-17.docker

docker image rm maven-toolchain-jdk-8-11-17:latest

docker image prune -f

docker tag maven-toolchain-jdk-8-11-17:latest kevinbuntrock/maven-toolchain-jdk-8-11-17:latest
docker login
docker push kevinbuntrock/maven-toolchain-jdk-8-11-17:latest
docker logout