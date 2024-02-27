FROM openjdk:17

COPY ./target/springbootdocker*.jar /usr/app/dockerDemo.jar

WORKDIR /usr/app

EXPOSE 8082

ENTRYPOINT ["java","-jar","dockerDemo.jar"]