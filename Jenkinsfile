// Jenkinsfile

pipeline {
    agent any 

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
                    // Menggunakan sh 'docker pull' dan 'docker run' untuk Composer,
                    // dengan asumsi Jenkins Agent (host) memiliki akses docker CLI
                    echo 'Pulling php:8.2-cli image...'
                    sh 'docker pull php:8.2-cli'

                    echo 'Running Composer install in a temporary container...'
                    sh 'docker run --rm -v $(pwd):/app -w /app php:8.2-cli composer install --no-dev --no-interaction'
                }
            }
        }

        stage('Run Unit Tests') {
            steps {
                script {
                    // Menjalankan PHPUnit di dalam container Docker PHP sementara
                    echo 'Running PHPUnit tests in a temporary container...'
                    sh 'docker run --rm -v $(pwd):/app -w /app php:8.2-cli vendor/bin/phpunit --colors=always'
                }
            }
        }

        stage('Deploy Application with Docker') {
            steps {
                echo 'Building Docker image for the PHP application...'
                script {
                    // Membangun image Docker dari Dockerfile lokal
                    // docker build -t nama-image:tag .
                    sh "docker build -t evellyn553/tugas8-php-app:${env.BUILD_NUMBER} ."

                    echo "Docker image evellyn553/tugas8-php-app:${env.BUILD_NUMBER} built."

                    echo 'Stopping and removing existing container (if any)...'
                    sh 'docker stop tugas8-php-container || true'
                    sh 'docker rm tugas8-php-container || true'

                    echo 'Running new Docker container...'
                    sh "docker run -d -p 80:80 --name tugas8-php-container evellyn553/tugas8-php-app:${env.BUILD_NUMBER}"
                    echo "Application deployed and running on http://localhost:80 (accessible via host's port 80)."
                }
            }
        }
    }

    post {
        always { echo 'Pipeline finished.' }
        success { echo 'Pipeline completed successfully!' }
        failure { echo 'Pipeline failed. Check logs for errors.' }
    }
}