FROM ubuntu:22.04

RUN apt update && apt upgrade -y

RUN DEBIAN_FRONTEND=noninteractive TZ=Asia/Kolkata apt-get -y install tzdata

ENV TZ="Asia/Calcutta"

# Create /app/logs directory
RUN mkdir -p /app/logs

#  set permissions (for non-root access)
RUN chmod -R 777 /app

RUN apt install -y openjdk-21-jre openjdk-21-jdk

COPY target/UIServer-0.0.1-SNAPSHOT.jar  app.jar

ENTRYPOINT exec java $JAVA_OPTS -jar app.jar

EXPOSE 8080