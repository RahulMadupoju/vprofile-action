FROM maven:3.9.9-eclipse-temurin-17 AS build_IMAGE

# The image already has Maven! No need to reinstall it.
# REMOVE THIS LINE:
# RUN apt update && apt install maven -y

WORKDIR /app
COPY ./ vprofile-project
WORKDIR /app/vprofile-project
RUN mvn clean install -DskipTests


FROM tomcat:9-jre11
LABEL "Project"="Vprofile"
LABEL "Author"="Imran"

RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build_IMAGE /app/vprofile-project/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
