pipeline {
    agent any
    
    environment {
        DOCKER_CREDENTIALS = 'd0612690-ab25-45ce-bcdd-68408a05156f'
        DOCKER_IMAGE = 'imane02/imageprojet:latest' // Ajout du tag 'latest'
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
                    docker.build(DOCKER_IMAGE, '-f Dockerfile .') // Construction de l'image Docker
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS) {
                        docker.image(DOCKER_IMAGE).push() // Pousser l'image vers Docker Hub
                    }
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    // Exécuter le conteneur Docker et mapper le port 8083 sur un port disponible de la machine hôte
                    docker.image(DOCKER_IMAGE).run('-p 8083:8083')
                }
            }
        }
    }
}
