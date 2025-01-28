pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'spring-boot-app'
        DOCKER_REGISTRY = 'localhost:5000'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                script {
                    withMaven(maven: 'maven-3'){
                        sh 'mvn install -DskipTests'
                    }
                }
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    sh 'docker build -t $DOCKER_IMAGE_NAME .'
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    withDockerRegistry([credentialsId: 'dockerhub-credentials', url: "$DOCKER_REGISTRY"]) {
                        sh 'docker push $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME'
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                // Add your deploy steps here
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}

