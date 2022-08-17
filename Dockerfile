FROM openjdk:11-jre 
ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]
