pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                // Get some code from a GitHub repository
                git 'https://github.com/tuser6794/MySpringBootApp.git'

                // Run Maven Wrapper Commands
                sh "./mvnw compile"

                echo 'Building the Project with maven compile'
            }
        }

        stage('Test') {
            steps {

                // Run Maven Wrapper Commands
                sh "./mvnw test"

                echo 'Testing the Project with maven test'
            }
        }

        stage('Package') {
            steps {

                // Run Maven Wrapper Commands
                sh "./mvnw package"

                echo 'Packaging the Project with maven package'
            }
        }
        stage('Containerize') {
            steps {

                // Run Maven Wrapper Commands
                sh "docker build -t myapp1 ."

                echo 'Containerizing the App with Docker'
            }
        }
        stage('Push Image') {
            steps {
                script {
                    try {
                        // Push the Docker image to Docker Hub
                        sh "docker push sonamdock"
                    } catch (Exception e) {
                        echo "Error: ${e}"
                        currentBuild.result = 'FAILURE'
                    }
                }
            }
        }
        stage('Deploy') {
            steps {

                // Run Maven Wrapper Commands
                sh "docker run -d -p 9091:9090 myapp"

                echo 'Deploy the App with Docker'
            }
        }
    }
}