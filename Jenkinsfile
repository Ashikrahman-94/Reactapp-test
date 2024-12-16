pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'customdocker-web:latest'
        DOCKER_USERNAME = 'ashikrahman24'
        BUILD_NUMBER = "${env.BUILD_NUMBER}"  // Jenkins build number
        DOCKER_REPO_DEV = "ashikrahman24/customdocker-webdev:${BUILD_NUMBER}"  // Replace with build number
        DOCKER_REPO_PROD = "ashikrahman24/customdocker-webprod:${BUILD_NUMBER}"  // Replace with build number
        SERVER_USER = 'ubuntu'  // Ensure this is the correct SSH user for your server
        SERVER_ADDRESS = '3.143.217.144'  // Replace with your server's IP address
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
                echo "Building branch: ${env.GIT_BRANCH}"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Running build script to build Docker image..."
                    sh 'chmod +x build.sh'   // Ensure build.sh is executable
                    sh './build.sh'          // Run the build.sh script to build the Docker image
                }
            }
        }

        stage('Tag & Push Docker Image') {
            steps {
                script {
                    if (env.GIT_BRANCH == 'origin/dev') {
                        echo "Pushing to Dev Repository"
                        sh "docker tag ${DOCKER_IMAGE} ${DOCKER_REPO_DEV}"
                        sh "docker push ${DOCKER_REPO_DEV}"
                    } else if (env.GIT_BRANCH == 'origin/master') {
                        echo "Pushing to Prod Repository"
                        sh "docker tag ${DOCKER_IMAGE} ${DOCKER_REPO_PROD}"
                        sh "docker push ${DOCKER_REPO_PROD}"
                    } else {
                        echo "No matching branch for deployment. Skipping Docker push."
                    }
                }
            }
        }

        stage('Deploy to Server') {
            steps {
                script {
                    echo "Deploying Docker image to server..."
                    sh 'chmod +x deploy.sh'  // Make deploy.sh executable
                    sh './deploy.sh'         // Run deploy.sh script to deploy the image
                }
            }
        }
    }

    post {
        success {
            echo 'Docker image built, pushed, and deployed successfully'
        }
        failure {
            echo 'Pipeline failed'
        }
    }
}
