pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/khadijaoumrani/springboot-deploy.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("imane02/imageprojet:latest")
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'd0612690-ab25-45ce-bcdd-68408a05156f') {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Run Container') {
            steps {
                script {
                    try {
                        // Attempt to remove any existing container with the same name
                        sh 'docker rm -f imageprojet || true'
                    } catch (Exception e) {
                        echo 'No existing container to remove'
                    }
                    // Run the container with restart policy set to always
                    sh 'docker run -d --name imageprojet --restart always -p 8082:8082 imane02/imageprojet:latest'
                }
            }
        }
    }
}
