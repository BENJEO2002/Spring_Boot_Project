pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                // Pull source code from GitHub
                git branch: 'main', url: 'https://github.com/BENJEO2002/Spring_Boot_Project.git'
            }
        }

        stage('Build JAR') {
            steps {
                // Build the Spring Boot JAR file using Maven
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build a Docker image
                sh 'docker build -t benjeo/spring-boot-app .'
            }
        }

        stage('Push Docker Image') {
            steps {
                // Push Docker image to DockerHub
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    docker push benjeo/spring-boot-app
                    """
                }
            }
        }

        stage('Deploy Application') {
            steps {
                // Run the Docker container
                sh """
                docker pull benjeo/spring-boot-app
                docker run -d -p 8080:8080 benjeo/spring-boot-app
                """
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline execution failed!'
        }
    }
}
