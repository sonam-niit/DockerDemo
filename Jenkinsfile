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
                sh "docker build -t myapp:${env.BUILD_NUMBER} ."

                echo 'Containerizing the App with Docker'
            }
        }
        stage('Push Image') {
            steps {
            			sh "sudo docker tag myapp:${env.BUILD_NUMBER} sonamsoni/cisco${env.BUILD_NUMBER}"
                        sh "sudo docker push sonamsoni/cisco${env.BUILD_NUMBER}"
                    echo "image pushed on DockerHub"
            	}
        }
        stage('Deploy') {
            steps {
				
				sh "docker stop mycontainer"
				sh "docker remove mycontainer"
                // Run Maven Wrapper Commands
                sh "docker run -d --name mycontainer -p 9091:9090 myapp${env.BUILD_NUMBER}"

                echo 'Deploy the App with Docker'
            }
        }
    }
}