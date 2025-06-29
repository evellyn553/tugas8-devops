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

        stage('Install Dep// Jenkinsfile

pipeline {
    agent any // Agent apa pun yang memiliki akses ke Docker daemon

    tools {
        // Kita tidak perlu mendefinisikan PHP/Composer di sini karena kita akan menggunakannya via Docker image
        // Pastikan Jenkins dapat mengakses Docker daemon (via /var/run/docker.sock)
    }

    stages {
        stage('Clone Repository') {
            steps {
                echo 'Cloning the Git repository...'
                git url: 'https://github.com/evellyn553/tugas8-devops.git', branch: 'main'
            }
        }

        stage('Install Dependencies') {
            steps {
                // Gunakan objek 'docker' yang disediakan oleh Docker Pipeline Plugin.
                // Ini akan menjalankan perintah Composer di dalam sebuah kontainer sementara
                script {
                    docker.image('php:8.2-cli').inside { // Memastikan PHP dan Composer tersedia di dalam kontainer ini
                        echo 'Installing Composer dependencies...'
                        sh 'composer install --no-dev --no-interaction'
                    }
                }
            }
        }

        stage('Run Unit Tests') {
            steps {
                script {
                    docker.image('php:8.2-cli').inside { // Menjalankan PHPUnit di dalam kontainer yang sama
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
                    // Perintah docker.build ini adalah perintah Groovy dari Jenkins Docker Pipeline Plugin,
                    // yang akan menjalankan build di Docker daemon host.
                    // Anda tidak perlu 'sh "docker build..."' lagi di sini.
                    def appImage = docker.build("evellyn553/tugas8-php-app:${env.BUILD_NUMBER}", ".") // Gunakan '.' untuk context build

                    echo "Docker image ${appImage.id} built. Pushing to Docker Hub (opsional) atau siap dijalankan."

                    echo 'Stopping and removing existing container (if any)...'
                    // Untuk perintah 'docker stop' dan 'docker rm', Jenkins perlu bisa memanggil Docker CLI.
                    // Pastikan Docker CLI terinstal di agent Jenkins atau gunakan 'docker.withRegistry'
                    // Jika 'agent any' tidak memiliki docker CLI, Anda harus menginstal agent lain atau
                    // menggunakan agent yang sudah memiliki Docker.
                    // UNTUK SAAT INI, KITA AKAN MENGASUMSIKAN JENKINS MASTER DAPAT MENJALANKAN PERINTAH INI
                    // KARENA ANDA SUDAH MEMETAKAN DOCKER.SOCK
                    sh 'docker stop tugas8-php-container || true' // Menghentikan container lama
                    sh 'docker rm tugas8-php-container || true'   // Menghapus container lama

                    echo 'Running new Docker container...'
                    // Perintah 'appImage.run' ini juga adalah perintah dari Docker Pipeline Plugin
                    // yang akan menjalankan kontainer di Docker daemon host.
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
}endencies') {
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