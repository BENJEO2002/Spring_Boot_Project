FROM openjdk:17-jdk
COPY target/spring_app_sak-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8081
CMD ["java", "-jar", "app.jar"]

