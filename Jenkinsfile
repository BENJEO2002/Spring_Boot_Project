pipeline {
    agent any
    tools {
        maven 'maven'
    }

    environment {
        DOCKER_IMAGE = 'benjeo/spring-boot-app'
    }

    stages {
        stage('Pre-Check Docker') {
            steps {
                sh 'docker --version'
            }
        }

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/BENJEO2002/Spring_Boot_Project.git'
            }
        }

        stage('Build JAR') {
            steps {
                sh 'mvn clean package'
                archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    docker push $DOCKER_IMAGE
                    """
                }
            }
        }

        stage('Deploy Application') {
            steps {
                sh """
                docker stop spring-boot-app || true
                docker rm spring-boot-app || true
                docker pull $DOCKER_IMAGE
                docker run -d --name spring-boot-app -p 8080:8080 $DOCKER_IMAGE
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
