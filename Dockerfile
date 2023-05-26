FROM amazoncorretto:17-alpine
ADD /target/spring-*.jar spring.jar
EXPOSE 8080
CMD ["java","-jar","spring.jar"]
