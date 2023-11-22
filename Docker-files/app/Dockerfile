# To build artifact
FROM openjdk:11 AS BUILD_IMAGE  
RUN apt update && apt install maven -y
RUN git clone 
RUN cd vprofile-project && git checkout docker && mvn install


# To copy artifact and run
FROM tomcat:9-jre11
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=BUILD_IMAGE vprofile-project/target/vprofile-v2.war /usr/loca/tomcat/webapps/ROOT.war

EXPOSE 8080
 