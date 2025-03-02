pipeline {
    agent any

    environment {
        AWS_REGION = 'eu-west-2'
    }

    stages {
        stage('Checkout Code') {
            steps {
               git branch: 'main', url: 'https://github.com/chiomanwanedo/bmi_repository.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }

        stage('Run Ansible Playbooks') {
            steps {
                sh 'ansible-playbook -i inventory install_dependencies.yml'
                sh 'ansible-playbook -i inventory deploy_app.yml'
            }
        }
    }
}
