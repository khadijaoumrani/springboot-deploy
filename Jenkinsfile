pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS = 'd0612690-ab25-45ce-bcdd-68408a05156f'
        DOCKER_IMAGE = 'imane02/imageprojet:latest'
    }

    triggers {
        githubPush()  // Trigger pipeline on GitHub push events
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
                    docker.build(DOCKER_IMAGE, '-f Dockerfile .')
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS) {
                        docker.image(DOCKER_IMAGE).push()
                    }
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    def container = docker.image(DOCKER_IMAGE)
                    try {
                        // Arrêtez et supprimez le conteneur existant s'il existe
                        sh "docker rm -f my_container || true"
                    } catch (Exception e) {
                        echo "No existing container to remove"
                    }
                    // Exécuter le nouveau conteneur Docker et mapper le port 8083
                    container.run('-d --name my_container -p 8083:8083')
                }
            }
        }
    }
}
