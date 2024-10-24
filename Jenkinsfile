pipeline {
    agent any
    stages {
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
                    sh "docker run -d -p 9090:8080 mariamayman/alx-swd1-m2d:latest"
                }
            }
        }
        stage('Check Connectivity') {
            steps {
                script {
                    def response = sh(script: "curl -s -o /dev/null -w '%{http_code}' http://localhost:9090", returnStdout: true)
                    if (response != "200") {
                        error("Website is not accessible!")
                    }
                }
            }
        }
    }
}
