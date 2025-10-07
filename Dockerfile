FROM php:8.4-fpm

# Install system dependencies & PHP extensions
RUN apt-get update && apt-get install -y \
    zip unzip curl git libzip-dev libonig-dev libxml2-dev libcurl4-openssl-dev \
    && docker-php-ext-install pdo_mysql mbstring xml bcmath zip curl

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory inside container
WORKDIR /var/www/name-generator

# Copy project files (optional if you use volumes, but good for image build cache)
COPY . .

# Install Laravel dependencies (optional during build)
RUN composer install --no-dev --optimize-autoloader

# Set permissions for Laravel folders
RUN chown -R www-data:www-data storage bootstrap/cache
RUN chmod -R 775 storage bootstrap/cache

EXPOSE 9000

CMD ["php-fpm"]
