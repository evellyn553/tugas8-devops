pipeline {
  agent any
  environment { COMPOSER_HOME = '/tmp' }

  stages {
    stage('Install Dependencies') {
      steps {
        echo '📦 Installing PHP dependencies...'
        sh 'docker run --rm -v "$WORKSPACE":/app -w /app composer install'
      }
    }
    stage('Run Unit Tests') {
      steps {
        echo '🧪 Running PHPUnit tests...'
        sh 'docker run --rm -v "$WORKSPACE":/app -w /app php:8.1-cli ./vendor/bin/phpunit --configuration phpunit.xml'
      }
    }
    stage('Deploy') {
      steps {
        echo '🚀 Building & Deploying app...'
        sh 'docker build -t php-simple-app "$WORKSPACE"'
        sh 'docker run -d -p 8080:80 php-simple-app'
      }
    }
  }

  post {
    success { echo '✅ Pipeline sukses!' }
    failure { echo '❌ Pipeline gagal, cek log ya.' }
  }
}
