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
                    docker.image('php:8.2-cli').inside {
                        echo 'Installing Composer dependencies...'
                        sh 'composer install --no-dev --no-interaction'
                    }
                }
            }
        }

        stage('Run Unit Tests') {
            steps {
                script {
                    docker.image('php:8.2-cli').inside {
                        echo 'Running PHPUnit tests...'
                        sh 'vendor/bin/phpunit --colors=always' 
                    }
                }
            }
        }

        stage('Deploy Application with Docker') {
            steps {
                echo 'Building Docker image for the PHP application...'
                script {
                    def appImage = docker.build("evellyn553/tugas8-php-app:${env.BUILD_NUMBER}", ".")

                    echo "Docker image ${appImage.id} built. Pushing to Docker Hub (opsional) atau siap dijalankan."

                    echo 'Stopping and removing existing container (if any)...'
                    sh 'docker stop tugas8-php-container || true'
                    sh 'docker rm tugas8-php-container || true'

                    echo 'Running new Docker container...'
                    appImage.run('-p 80:80 --name tugas8-php-container -d')
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