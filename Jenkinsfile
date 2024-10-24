pipeline {
    agent any
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("alx-swd1-m2d/java-app")
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
                    sh "docker pull alx-swd1-m2d/java-app:latest"
                }
            }
        }
        stage('Run the Image') {
            steps {
                script {
                    sh "docker run -d -p 8080:8080 alx-swd1-m2d/java-app:latest"
                }
            }
        }
        stage('Check Connectivity') {
            steps {
                script {
                    def response = sh(script: "curl -s -o /dev/null -w '%{http_code}' http://localhost:8080", returnStdout: true)
                    if (response != "200") {
                        error("Website is not accessible!")
                    }
                }
            }
        }
    }
}
