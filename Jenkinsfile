pipeline {
    agent any

    environment {
        AWS_REGION = 'eu-west-2'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/chiomanwanedo/bmi_repository.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
    }
}
