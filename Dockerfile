FROM openjdk:8-jdk-alpine
VOLUME /tmp
ARG DEPENDENCY=target/dependency
COPY ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY ${DEPENDENCY}/META-INF /app/META-INF
COPY ${DEPENDENCY}/BOOT-INF/classes /app
ENTRYPOINT ["java","-cp","app:app/lib/*","hello.Application"]
#Install maven
RUN apt-get update
RUN apt-get install -y maven

#Set the working directory for RUN and ADD commands
WORKDIR /code

#Copy the SRC, LIB and pom.xml to WORKDIR
ADD pom.xml /code/pom.xml
ADD lib /code/lib
ADD src /code/src

#Build the code
RUN ["mvn", "clean"]
RUN ["mvn", "install"]

#Optional you can include commands to run test cases.

#Port the container listens on
EXPOSE 8081
