pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS = 'd0612690-ab25-45ce-bcdd-68408a05156f'
        DOCKER_IMAGE = 'imane02/imageprojet:latest'
    }

    triggers {
        githubPush()  // Déclenche le pipeline sur les événements push de GitHub
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

        stage('Deploy Application') {
            steps {
                script {
                    sh 'docker-compose pull mavenapp'
                    sh 'docker-compose up -d mavenapp'
                }
            }
        }

        stage('Restart Application') {
            steps {
                script {
                    sh 'docker-compose restart mavenapp'
                }
            }
        }
    }
}
