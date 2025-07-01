pipeline {
    agent any

    stages {
        stage('Run Unit Tests') {
            steps {
                script {
                    echo '🧪 Running PHPUnit tests...'
                    sh '''
                        pwd
                        docker run --rm -v "$PWD":/app -w /app php:8.2-cli bash -c "\
                            apt-get update && \
                            apt-get install -y unzip wget && \
                            wget -O phpunit https://phar.phpunit.de/phpunit-9.phar && \
                            chmod +x phpunit && \
                            php phpunit --colors=always"
                    '''
                }
            }
        }

        stage('Deploy Application with Docker') {
            steps {
                echo '🚀 Deploying application...'
                // Tambahkan deployment script kamu di sini
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline succeeded.'
        }
        failure {
            echo '❌ Pipeline failed. Check logs for errors.'
        }
    }
}
