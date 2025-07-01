pipeline {
    agent any

    environment {
        COMPOSER_HOME = '/tmp'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                echo '📦 Installing PHP dependencies with Composer...'
                sh 'docker run --rm -v ${WORKSPACE}:/app -w /app composer install'
            }
        }

        stage('Run Unit Tests') {
            steps {
                echo '🧪 Running unit tests with PHPUnit...'
                sh 'docker run --rm -v ${WORKSPACE}:/app -w /app php:8.1-cli php vendor/bin/phpunit --colors=always'
            }
        }

        stage('Deploy Application with Docker') {
            steps {
                echo '🚀 Deploying application using Docker...'
                sh 'docker build -t php-simple-app .'
                sh 'docker run -d -p 8080:80 php-simple-app'
            }
        }
    }

    post {
        success {
            echo '✅ Build and deployment successful!'
        }
        failure {
            echo '❌ Pipeline failed. Please check the logs.'
        }
    }
}
