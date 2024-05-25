pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                // Build steps...
            }
        }

        stage('Docker Build and Push') {
            steps {
                // Docker build and push steps...
            }
        }

        stage('Deploy Application') {
            steps {
                script {
                    if (isUnix()) {
                        sh 'nohup java -jar app.jar &'
                    } else {
                        bat 'start /b java -jar app.jar'
                    }
                }
            }
        }

        stage('Restart Application') {
            when {
                expression {
                    // Only execute if Deploy Application stage succeeds
                    currentBuild.result == null || currentBuild.result == 'SUCCESS'
                }
            }
            steps {
                script {
                    if (isUnix()) {
                        sh 'nohup java -jar app.jar &'
                    } else {
                        bat 'start /b java -jar app.jar'
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
