pipeline {
    agent any

    environment {
        IMAGE_NAME = "new/new1"
        AWS_REGION = "ap-south-1"
        ECR_REGISTRY = "950876115206.dkr.ecr.ap-south-1.amazonaws.com/new/new1"
        ECR_REPO = "${ECR_REGISTRY}/${IMAGE_NAME}"
        AWS_CREDENTIALS_ID = "aws-ecr-creds"
    }

    stages {
        stage('Clone Code') {
            steps {
                git branch: 'main', credentialsId: 'c399a8d0-2318-4d7c-afd3-83c0444fb0de', url: 'https://github.com/SAHAPRE/my-pipeline-09-2.git'
            }
        }

        stage('Run Tests') {
            steps {
                sh './run_tests.sh'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Login to AWS ECR') {
            steps {
                withCredentials([usernamePassword(credentialsId: AWS_CREDENTIALS_ID, usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh '''
                        aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
                        aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
                        aws configure set region ${AWS_REGION}
                        aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin 950876115206.dkr.ecr.ap-south-1.amazonaws.com
                    '''
                }
            }
        }

        stage('Push to ECR') {
            steps {
                sh """
                    docker tag new/new1:latest 950876115206.dkr.ecr.ap-south-1.amazonaws.com/new/new1:latest
                    docker push 950876115206.dkr.ecr.ap-south-1.amazonaws.com/new/new1:latest
                """
            }
        }
    }
}

post {
        always {
            junit 'report.xml'
            cleanWs()
        }
    }
}
