pipeline {
    agent any
    stages {
	stage('Cleanup') {
            steps {
                script {
                    sh "docker ps -q --filter 'name=alx-swd1-m2d' | xargs -r docker stop"
                    sh "docker ps -aq --filter 'name=alx-swd1-m2d' | xargs -r docker rm"
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("mariamayman/alx-swd1-m2d")
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials') {
                        dockerImage.push("latest")
                    }
                }
            }
        }
        stage('Pull on Another Agent') {
            steps {
                script {
                    sh "docker pull mariamayman/alx-swd1-m2d:latest"
                }
            }
        }
        stage('Run the Image') {
            steps {
                script {
                    sh "docker run -d -p 9090:9090 mariamayman/alx-swd1-m2d:latest"
                }
            }
        }
        stage('Check Connectivity') {
            steps {
                script {
                    def response = sh(script: "curl -s -o /dev/null -w '%{http_code}' http://localhost:8080", returnStdout: true).trim()
                    if (response != "200") {
                        error("Website is not accessible!")
                    }
                }
            }
        }
    }
}
