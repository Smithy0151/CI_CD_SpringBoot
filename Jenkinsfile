pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID = "235494813843"
        AWS_DEFAULT_REGION = "us-east-1"
        IMAGE_REPO_NAME = "springboot"
        IMAGE_TAG = "latest"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
    }
   
    stages {
        
        stage('Logging into AWS ECR') {
            steps {
                script {
                    sh """aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${REPOSITORY_URI}"""
                }
            }
        }
        
        stage('Cloning Git') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'your-credentials-id', url: 'https://github.com/sd031/aws_codebuild_codedeploy_nodeJs_demo.git']]])     
            }
        }
  
        stage('Building image') {
            steps {
                script {
                    // Specify the build context (the location of your Dockerfile)
                    dockerImage = docker.build("${IMAGE_REPO_NAME}:${IMAGE_TAG}", ".")
                }
            }
        }
   
        stage('Pushing to ECR') {
            steps {
                script {
                    // Tag the image
                    sh """docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:${IMAGE_TAG}"""
                    // Push the image to ECR
                    sh """docker push ${REPOSITORY_URI}:${IMAGE_TAG}"""
                }
            }
        }
    }
}
