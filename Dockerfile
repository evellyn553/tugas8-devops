# Dockerfile

# Menggunakan base image PHP-Apache terbaru
FROM php:8.2-apache

# Menginstal ekstensi PHP yang dibutuhkan (misal untuk Composer atau MySQL jika nanti pakai DB)
RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable mysqli pdo_mysql

# Menginstal Composer (PHP dependency manager)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Mengatur working directory di dalam container
WORKDIR /var/www/html

# Menghapus default index.html dari Apache
RUN rm -rf /var/www/html/index.html

# Menyalin semua file aplikasi dari lokal ke container
COPY . /var/www/html

# Menginstal dependencies Composer (termasuk PHPUnit)
# --no-dev: tidak menginstal dev dependencies di production image (opsional)
# --optimize-autoloader: untuk performa
# --no-interaction: menghindari pertanyaan interaktif
RUN composer install --no-dev --optimize-autoloader --no-interaction

# Expose port (opsional, karena apache base image sudah expose 80)
EXPOSE 80

# Command default untuk Apache (sudah ada di base image php:*-apache)
# CMD ["apache2-foreground"]