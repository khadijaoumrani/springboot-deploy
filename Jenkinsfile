node {
    def WORKSPACE = "C:/Users/pc/Document/GitProject/springboot-deploy"
    def dockerImageTag = "springboot-deploy:${env.BUILD_NUMBER}"
    def dockerImage = null

    try {
        stage('Cleanup') {
            deleteDir()  // Clean the workspace
        }

        stage('Clone Repo') {
            git url: 'https://github.com/khadijaoumrani/springboot-deploy.git', branch: 'master'
        }

        stage('List files') {
            bat 'dir'  // List files to verify Dockerfile presence
        }

        stage('Verify Dockerfile') {
            if (!fileExists('Dockerfile')) {
            error "Dockerfile not found in workspace"
        }

        }

        stage('Build docker') {
            dockerImage = docker.build(dockerImageTag)
        }

        stage('Deploy docker') {
            echo "Docker Image Tag Name: ${dockerImageTag}"
            bat script: '''
                docker stop springboot-deploy || true
                docker rm springboot-deploy || true
                docker run --name springboot-deploy -d -p 8081:8081 springboot-deploy:${env.BUILD_NUMBER}
            '''
        }
    } catch(e) {
        currentBuild.result = "FAILED"
        throw e
    } finally {
        notifyBuild(currentBuild.result)
    }
}

def notifyBuild(String buildStatus = 'STARTED') {
    // build status of null means successful
    buildStatus = buildStatus ?: 'SUCCESSFUL'
    // Default values
    def colorName = 'RED'
    def colorCode = '#FF0000'
    def now = new Date()
    // message
    def subject = "${buildStatus}, Job: ${env.JOB_NAME} FRONTEND - Deployment Sequence: [${env.BUILD_NUMBER}]"
    def summary = "${subject} - Check On: (${env.BUILD_URL}) - Time: ${now}"
    def subject_email = "Spring boot Deployment"
    def details = """<p>${buildStatus} JOB </p>
        <p>Job: ${env.JOB_NAME} - Deployment Sequence: [${env.BUILD_NUMBER}] - Time: ${now}</p>
        <p>Check console output at "<a href="${env.BUILD_URL}">${env.JOB_NAME}</a>"</p>"""

    // Email notification
    emailext (
        to: "khadijaoumrani03@gmail.com",
        subject: subject_email,
        body: details,
        recipientProviders: [[$class: 'DevelopersRecipientProvider']]
    )
}
