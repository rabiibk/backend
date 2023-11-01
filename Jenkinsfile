pipeline {
    agent any

    environment {
        NEXUS_URL = 'http://192.168.12.150:8081/'
        NEXUS_CREDENTIALS_ID = '2a293b0f-5ae7-461c-b30a-928060cf2246'
        DOCKER_REPO = 'rabii1990/backend'
       
        DOCKERFILE_PATH = '/home/rabii/docker/backend/Dockerfile'
        DOCKER_IMAGE_NAME = 'rabii1990/backend'
        DOCKER_IMAGE_TAG = 'new2'
    }

    stages {
        stage('GIT') {
            steps {
                echo 'My first job pipeline'
                git 'https://github.com/rabiibk/backend.git'
            }
        }

        stage('Compiling') {
            steps {
                sh 'mvn compile'
            }
        }

        stage('SONARQUBE') {
            steps {
                sh 'mvn sonar:sonar -Dsonar.login=admin -Dsonar.password=sonar'
            }
        }

        stage('NEXUS') {
            steps {
                sh 'mvn deploy -DskipTests'
            }
        }
    

        stage('Pull JAR & Build Docker Image') {
            steps {
                sh "curl -o java.jar http://192.168.12.150:8081/repository/maven-releases/com/example/java8/2.0/java-2.0.jar"  // Télécharger le JAR
                
                sh " docker build -t java:new2 -f /home/rabii/docker/backend/Dockerfile /home/rabii/docker/backend/"
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                
                sh " docker tag java:new2 ${DOCKER_REPO}:$DOCKER_IMAGE_TAG"
                sh "docker login -u rabii1990 -p rabiiradar2012"
                sh "docker push ${DOCKER_REPO}:$DOCKER_IMAGE_TAG"
                
            }
        }
    }

    post {
        always {
            sh "rm -f java8.jar"
        }
    }
}
