FROM gradle:jdk8 as builder
USER root
WORKDIR /home/gradle/
COPY . /home/gradle/
RUN	./gradlew clean assemble

FROM openjdk:8-alpine
USER 1000:1000
ENV PORT 8080
EXPOSE 8080
WORKDIR /home/
COPY --from=builder /home/gradle/build/libs/spring-music.jar /home/
ENTRYPOINT [ "java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-jar", "/home/spring-music.jar" ]
