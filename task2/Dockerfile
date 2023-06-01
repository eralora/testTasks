#### Here I am using multi-stage build for reducing image size

#First stage to build the code
FROM maven:3.8.5-openjdk-17-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

#Second stage build small jre image for next stage 
FROM amazoncorretto:17.0.3-alpine as javaData
# required for strip-debug to work
RUN apk add --no-cache binutils
# Build small JRE image
RUN $JAVA_HOME/bin/jlink \
         --verbose \
         --add-modules ALL-MODULE-PATH \
         --strip-debug \
         --no-man-pages \
         --no-header-files \
         --compress=2 \
         --output /customjre

#Third stage copy files and run application
#Using alpine:latest instead of jdk:17-slim or alpine because jdk:17 size is 400 MB and my image need to be no larger than 150 MB
FROM alpine:latest
#First copy built .jar file from first stage
COPY --from=build /home/app/target/hallo-0.0.1-SNAPSHOT.jar /usr/local/lib/hallo.jar
#Next copy built small JRE from second stage
COPY --from=javaData /customjre /jre
#Expose appropriate port 
EXPOSE 8080
#Start application
ENTRYPOINT ["/jre/bin/java","-jar","/usr/local/lib/hallo.jar"]