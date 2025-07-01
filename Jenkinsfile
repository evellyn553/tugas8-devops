// Jenkinsfile untuk pipeline CI/CD PHP
pipeline {
    // Menentukan agent (node Jenkins) yang akan menjalankan pipeline.
    // 'any' berarti Jenkins akan menggunakan agent mana pun yang tersedia.
    agent any

    // Opsi pipeline.
    options {
        // Mencegah Jenkins melakukan checkout SCM secara otomatis di awal pipeline.
        // Kita akan melakukan checkout secara manual di stage 'Prepare Workspace'
        // setelah membersihkan workspace.
        skipDefaultCheckout true
    }

    // Mendefinisikan variabel lingkungan yang akan digunakan di seluruh pipeline.
    environment {
        // Mengatur COMPOSER_HOME ke direktori sementara di dalam container Docker.
        COMPOSER_HOME = '/tmp'
        // Menentukan nama untuk container aplikasi yang akan di-deploy.
        APP_CONTAINER_NAME = 'php-simple-app-container'
        // Menentukan port untuk aplikasi yang di-deploy.
        // Diganti dari 8080 ke 8081 untuk menghindari konflik dengan Jenkins itu sendiri.
        APP_PORT = '8081'
        // MENGUBAH INI: Menentukan subdirektori tempat kode proyek berada setelah checkout.
        // Berdasarkan log debugging terakhir, kode proyek berada di dalam folder 'php-simple-app/php-simple-app'.
        PROJECT_SUBDIR = 'php-simple-app/php-simple-app'
    }

    // Mendefinisikan tahapan (stages) dari pipeline.
    stages {
        // Stage pertama: Mempersiapkan workspace dengan membersihkannya dan melakukan checkout kode terbaru.
        stage('Prepare Workspace') {
            steps {
                echo '🧹 Membersihkan workspace dan melakukan checkout kode terbaru...'
                // Membersihkan seluruh isi direktori workspace Jenkins.
                // Ini penting untuk memastikan setiap build dimulai dari keadaan bersih.
                cleanWs()
                // Melakukan checkout kode dari Source Code Management (SCM) yang dikonfigurasi.
                checkout scm
            }
        }

        // Stage kedua: Menginstal dependensi PHP menggunakan Composer di dalam container Docker.
        stage('Install Dependencies') {
            steps {
                echo '📦 Menginstal dependensi PHP...'
                // Memastikan perintah dijalankan di direktori subfolder proyek di workspace Jenkins.
                dir("${env.WORKSPACE}/${env.PROJECT_SUBDIR}") { // Masuk ke subfolder php-simple-app/php-simple-app
                    // Menjalankan Composer di dalam container Docker.
                    // Menggunakan multi-line string untuk menjalankan beberapa perintah bash.
                    sh """docker run --rm -v "${env.WORKSPACE}/${env.PROJECT_SUBDIR}:/app" -w /app composer:2 bash -c "
                                echo '--- Debugging /app directory ---'
                                echo 'Current working directory inside container:'
                                pwd # Menampilkan working directory di dalam container
                                echo 'Listing contents of /app:'
                                ls -l /app # Menampilkan isi dari folder /app untuk verifikasi composer.json
                                echo '--- End Debugging ---'
                                echo 'Mencoba menginstal dependensi Composer...'
                                composer install --no-dev --no-interaction # Menjalankan instalasi Composer
                            "
                    """
                }
            }
        }

        // Stage ketiga: Menjalankan unit test PHP menggunakan PHPUnit di dalam container Docker.
        stage('Run Unit Tests') {
            steps {
                echo '🧪 Menjalankan PHPUnit tests...'
                // Memastikan perintah dijalankan di direktori subfolder proyek di workspace Jenkins.
                dir("${env.WORKSPACE}/${env.PROJECT_SUBDIR}") { // Masuk ke subfolder php-simple-app/php-simple-app
                    // Menjalankan PHPUnit di dalam container Docker PHP.
                    sh """docker run --rm -v "${env.WORKSPACE}/${env.PROJECT_SUBDIR}:/app" -w /app php:8.1-cli ./vendor/bin/phpunit --configuration phpunit.xml"""
                }
            }
        }

        // Stage keempat: Membangun image Docker aplikasi dan menjalankannya.
        stage('Deploy Application with Docker') {
            steps {
                echo '🚀 Membangun dan menjalankan image Docker aplikasi...'
                // Memastikan perintah dijalankan di direktori subfolder proyek di workspace Jenkins.
                dir("${env.WORKSPACE}/${env.PROJECT_SUBDIR}") { // Masuk ke subfolder php-simple-app/php-simple-app
                    // Menghentikan dan menghapus container aplikasi yang mungkin sedang berjalan.
                    // '|| true' mencegah pipeline gagal jika container belum ada.
                    sh "docker stop ${env.APP_CONTAINER_NAME} || true"
                    sh "docker rm ${env.APP_CONTAINER_NAME} || true"

                    // Membangun image Docker dari Dockerfile di root proyek.
                    sh 'docker build -t php-simple-app .'
                    // Menjalankan container Docker aplikasi di background (-d).
                    // Memetakan port APP_PORT (8081) di host ke port 80 di container.
                    sh "docker run -d -p ${env.APP_PORT}:80 --name ${env.APP_CONTAINER_NAME} php-simple-app"
                    echo "✅ Aplikasi seharusnya berjalan di http://localhost:${env.APP_PORT}"
                }
            }
        }
    }

    // Bagian post-build actions, akan dijalankan setelah semua stages selesai.
    post {
        // Jika pipeline gagal di stage mana pun.
        failure {
            echo '❌ Pipeline gagal, cek log untuk detail kesalahan.'
        }
        // Jika pipeline berhasil menyelesaikan semua stages.
        success {
            echo '✅ Pipeline sukses! Aplikasi berhasil di-deploy.'
        }
    }
}
