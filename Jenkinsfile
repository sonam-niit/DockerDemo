def containerName = "spring_container"
def imageName = "spring_image"
def tag = "latest"

pipeline {
    agent any

    stages {
        stage('Checkout Source Code') {
            steps {
                checkout scm
            }
        }

        stage("Compilation") {
            steps {
                sh "mvn clean install -DskipTests"
            }
        }

        stage('Image Build') {
            steps {
                sh "docker build -t $imageName:${env.BUILD_NUMBER} --pull --no-cache ."
                echo "Image build complete"
            }
        }

        stage('Run Application') {
            steps {
                script {
                    try {
                        // Stop existing Container if exists
                        sh "docker stop $containerName || true"
                        sh "docker rm $containerName || true"

                        // Start the application container
                        sh "docker run -d --name $containerName -p 8082:8082 $imageName:${env.BUILD_NUMBER}"
                    } catch (Exception e) {
                        echo "Error: ${e}"
                        currentBuild.result = 'FAILURE'
                    }
                }
            }
        }

        stage('Push Image') {
            steps {
                script {
                    try {
                        // Push the Docker image to Docker Hub
                        sh "docker push $imageName:${env.BUILD_NUMBER}"
                    } catch (Exception e) {
                        echo "Error: ${e}"
                        currentBuild.result = 'FAILURE'
                    }
                }
            }
        }
    }

    post {
        always {
            // Stop and remove the container after the job completes
            script {
                sh "docker stop $containerName || true"
                sh "docker rm $containerName || true"
            }
        }
    }
}
