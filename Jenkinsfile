pipeline {
    agent any

    environment {
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
                    echo 'Pulling composer:2 image...'
                    sh 'docker pull composer:2'

                    echo 'Running Composer install in a temporary container...'
                    sh 'docker run --rm -v "$WORKSPACE/PHP-SIMPLE-APP:/app" -w /app composer:2 composer install --no-dev --no-interaction'
                }
            }
        }

        stage('Run Unit Tests') {
            steps {
                script {
                    echo 'Running PHPUnit tests in a temporary container...'
                    sh 'docker run --rm -v "$WORKSPACE/PHP-SIMPLE-APP:/app" -w /app php:8.2-cli ./vendor/bin/phpunit --colors=always'
                }
            }
        }

        stage('Deploy Application with Docker') {
            steps {
                script {
                    echo 'Building Docker image...'
                    sh "docker build -t evellyn553/tugas8-php-app:${env.BUILD_NUMBER} PHP-SIMPLE-APP"

                    echo 'Stopping old container (if exists)...'
                    sh 'docker stop tugas8-php-container || true'
                    sh 'docker rm tugas8-php-container || true'

                    echo 'Running new container...'
                    sh "docker run -d -p 80:80 --name tugas8-php-container evellyn553/tugas8-php-app:${env.BUILD_NUMBER}"
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check logs for errors.'
        }
    }
}
