pipeline {
  agent any
  environment { COMPOSER_HOME = '/tmp' }

  stages {
    stage('Checkout') {
      steps { checkout scm }
    }

    stage('Install Dependencies') {
      steps {
        echo '📦 Installing PHP dependencies...'
        dir("${env.WORKSPACE}") {
          sh 'docker run --rm -v "${PWD}:/app" -w /app composer install'
        }
      }
    }

    stage('Run Unit Tests') {
      steps {
        echo '🧪 Running PHPUnit tests...'
        dir("${env.WORKSPACE}") {
          sh 'docker run --rm -v "${PWD}:/app" -w /app php:8.1-cli ./vendor/bin/phpunit --configuration phpunit.xml'
        }
      }
    }

    stage('Deploy Application with Docker') {
      steps {
        echo '🚀 Building & running Docker image...'
        dir("${env.WORKSPACE}") {
          sh 'docker build -t php-simple-app .'
          sh 'docker run -d -p 8080:80 php-simple-app'
        }
      }
    }
  }

  post {
    failure { echo '❌ Pipeline gagal, cek log.' }
    success { echo '✅ Pipeline sukses!' }
  }
}
