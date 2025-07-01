pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                echo '📥 Cloning repository...'
                git url: 'https://github.com/evellyn553/tugas8-devops.git', branch: 'main'
            }
        }

        stage('Install Dependencies') {
            steps {
                echo '📦 Installing PHP dependencies with Composer...'
                sh '''
                    docker run --rm -v "$PWD":/app -w /app composer install
                '''
            }
        }

        stage('Run Unit Tests') {
            steps {
                echo '🧪 Running PHPUnit tests...'
                sh '''
                    docker run --rm -v "$PWD":/app -w /app php:8.2-cli bash -c "\
                        apt-get update && \
                        apt-get install -y unzip wget && \
                        wget -O phpunit https://phar.phpunit.de/phpunit-9.phar && \
                        chmod +x phpunit && \
                        php phpunit --colors=always --configuration=phpunit.xml"
                '''
            }
        }

        stage('Deploy Application with Docker') {
            steps {
                echo '🚀 Deployment stage (optional step, implement as needed)'
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline succeeded.'
        }
        failure {
            echo '❌ Pipeline failed. Please check the logs.'
        }
    }
}
