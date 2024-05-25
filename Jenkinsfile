pipeline {
    agent any
    
    environment {
        DOCKER_CREDENTIALS = 'd0612690-ab25-45ce-bcdd-68408a05156f'
        DOCKER_IMAGE = 'imane02/imageprojet'
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
        
        stage('Run Container') {
            steps {
                script {
                    // Run Docker container and map port 8083
                    docker.image(DOCKER_IMAGE).run('-p 8083:8083')
                }
            }
        }
    }
}
