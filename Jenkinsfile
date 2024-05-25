pipeline {
    agent any
    
    environment {
        DOCKER_CREDENTIALS = 'docker-hub-credentials'
        DOCKER_IMAGE = 'naya34045662/imageprojet'
    }
    
    stages {
        stage('Clone Repository') {
            steps {
                git url: 'https://github.com/khadijaoumrani/springboot-deploy.git', branch: 'master'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(DOCKER_IMAGE, '-f Dockerfile .') // Build Docker image from Dockerfile in current directory
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS) {
                        docker.image(DOCKER_IMAGE).push('latest') // Push the built image to Docker Hub
                    }
                }
            }
        }
    }
}
