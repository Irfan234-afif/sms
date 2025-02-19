# Menggunakan base image PHP
FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    libonig-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    curl \
    git \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# Configure and install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip pdo pdo_mysql

# Set php config
COPY php.ini /usr/local/etc/php/php.ini

# Set argumen for UID and GID
ARG USER_ID
ARG GROUP_ID

# Create user and group in container that match with host
RUN groupadd -g ${GROUP_ID} laravel && \
    useradd -u ${USER_ID} -g laravel -m laravel && \
    chown -R laravel:laravel /var/www/html

# Set working directory
WORKDIR /var/www/html

# Copy application files
COPY . .

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Allow Composer to run plugins as root
ENV COMPOSER_ALLOW_SUPERUSER=1

# Install PHP dependencies
RUN composer install

# Install npm dependencies
RUN npm install

# Pastikan folder dengan permission benar
RUN chown -R laravel:laravel /var/www/html/storage /var/www/html/bootstrap/cache

# Expose port 9000 and start php-fpm server
EXPOSE 9000
USER laravel
CMD ["php-fpm"]
