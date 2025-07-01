pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                echo '📥 Cloning the Git repository...'
                git url: 'https://github.com/evellyn553/tugas8-devops.git', branch: 'main'
            }
        }

        stage('Run Unit Tests') {
            steps {
                script {
                    echo '🧪 Running PHPUnit tests...'
                    sh '''
                        docker run --rm -v "$(pwd):/app" -w /app php:8.2-cli bash -c "
                            apt-get update &&
                            apt-get install -y unzip wget &&
                            wget -O phpunit https://phar.phpunit.de/phpunit-9.phar &&
                            chmod +x phpunit &&
                            php phpunit --colors=always
                        "
                    '''
                }
            }
        }

        stage('Deploy Application with Docker') {
            steps {
                script {
                    echo '🐳 Building Docker image...'
                    sh "docker build -t evellyn553/tugas8-php-app:${env.BUILD_NUMBER} ."

                    echo '🛑 Stopping old container...'
                    sh 'docker stop tugas8-php-container || true'
                    sh 'docker rm tugas8-php-container || true'

                    echo '🚀 Starting new container...'
                    sh "docker run -d -p 80:80 --name tugas8-php-container evellyn553/tugas8-php-app:${env.BUILD_NUMBER}"
                }
            }
        }
    }

    post {
        always {
            echo '🏁 Pipeline finished.'
        }
        success {
            echo '✅ Pipeline completed successfully!'
        }
        failure {
            echo '❌ Pipeline failed. Check logs for errors.'
        }
    }
}
