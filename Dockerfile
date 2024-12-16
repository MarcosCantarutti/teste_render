# Use uma imagem base oficial do PHP
FROM php:8.2-fpm

# Instale extens�es do PHP necess�rias para o Laravel
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Instale o Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Configure o diret�rio de trabalho
WORKDIR /var/www

# Copie os arquivos para o cont�iner
COPY . .

# Configure as permiss�es para a pasta storage e cache
RUN chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www/storage

# Exponha a porta que o Laravel usar�
EXPOSE 8000

# Comando para iniciar o Laravel
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
