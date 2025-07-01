pipeline {
    agent any

    stages {
        stage('Run Unit Tests') {
            steps {
                script {
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
        }

        stage('Deploy Application with Docker') {
            steps {
                echo '🚀 Deploying application...'
                // Tambahkan langkah deploy kamu di sini
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
