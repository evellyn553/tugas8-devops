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
                sh 'docker run --rm -v $PWD/php-simple-app:/app -w /app composer install'
            }
        }

        stage('Run Unit Tests') {
            steps {
                echo '🧪 Running PHPUnit tests...'
                sh 'docker run --rm -v $PWD/php-simple-app:/app -w /app php:8.1-cli php vendor/bin/phpunit tests'
            }
        }

        stage('Deploy Application with Docker') {
            steps {
                echo '🚀 Deploying with Docker...'
                sh 'docker-compose -f php-simple-app/docker-compose.yml up -d --build'
            }
        }
    }

    post {
        failure {
            echo '❌ Pipeline failed. Please check the logs.'
        }
    }
}
