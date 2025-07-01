pipeline {
    agent any

    environment {
        COMPOSER_HOME = '/tmp'
    }

    stages {
        stage('Clean Workspace') {
            steps {
                deleteDir()
            }
        }

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                echo '📦 Installing PHP dependencies with Composer...'
                sh 'docker run --rm -v "$WORKSPACE":/app -w /app composer install'
            }
        }

        stage('Run Unit Tests') {
            steps {
                echo '🧪 Running PHPUnit tests...'
                sh 'docker run --rm -v "$WORKSPACE":/app -w /app php:8.1-cli ./vendor/bin/phpunit --configuration phpunit.xml'
            }
        }

        stage('Deploy Application with Docker') {
            steps {
                echo '🚀 Deploying application with Docker...'
                sh 'docker build -t php-simple-app "$WORKSPACE"'
                sh 'docker run -d -p 8080:80 php-simple-app'
            }
        }
    }

    post {
        failure {
            echo '❌ Pipeline failed. Please check the logs.'
        }
        success {
            echo '✅ Pipeline succeeded!'
        }
    }
}
