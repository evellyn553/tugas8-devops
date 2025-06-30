// Jenkinsfile

pipeline {
    agent any

    environment {
        // Mengarahkan Docker CLI ke Docker daemon host Windows (bukan socket Unix)
        DOCKER_HOST = 'tcp://host.docker.internal:2375'
    }

    stages {
        stage('Clone Repository') {
            steps {
                echo 'Cloning the Git repository...'
                git url: 'https://github.com/evellyn553/tugas8-devops.git', branch: 'main'
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    echo 'Pulling php:8.2-cli image...'
                    sh 'docker pull php:8.2-cli'

                    echo 'Running Composer install in a temporary container...'
                    sh 'docker run --rm -v "${WORKSPACE}:/app" -w /app php:8.2-cli composer install --no-dev --no-interaction'
                }
            }
        }

        stage('Run Unit Tests') {
            steps {
                script {
                    echo 'Running PHPUnit tests in a temporary container...'
                    sh 'docker run --rm -v "${WORKSPACE}:/app" -w /app php:8.2-cli vendor/bin/phpunit --colors=always'
                }
            }
        }

        stage('Deploy Application with Docker') {
            steps {
                script {
                    echo 'Building Docker image for the PHP application...'
                    sh "docker build -t evellyn553/tugas8-php-app:${env.BUILD_NUMBER} ."

                    echo "Docker image evellyn553/tugas8-php-app:${env.BUILD_NUMBER} built."

                    echo 'Stopping and removing existing container (if any)...'
                    sh 'docker stop tugas8-php-container || true'
                    sh 'docker rm tugas8-php-container || true'

                    echo 'Running new Docker container...'
                    sh "docker run -d -p 80:80 --name tugas8-php-container evellyn553/tugas8-php-app:${env.BUILD_NUMBER}"
                    echo "Application deployed and running on http://localhost:80"
                }
            }
        }
    }

    post {
        always { echo 'Pipeline finished.' }
        success { echo 'Pipeline completed successfully!' }
        failure { echo 'Pipeline failed. Check logs for errors.' }
    }
}
