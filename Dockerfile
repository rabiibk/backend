FROM openjdk:11

# Créez un répertoire d'application dans l'image
WORKDIR /home/rabii/backend

# Téléchargez le fichier JAR depuis le référentiel Nexus en utilisant curl
RUN curl -o java8.jar http://192.168.12.150:8081/repository/maven-releases/com/example/java8/2.0/java8-2.0.jar

# Commande pour exécuter l'application (cela exécute le JAR lorsqu'un conteneur est démarré)
CMD ["java", "-jar", "java8.jar"]
