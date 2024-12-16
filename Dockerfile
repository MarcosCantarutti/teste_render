# Use a imagem base oficial do PHP (8.2 FPM) para trabalhar com Laravel
FROM php:8.2-fpm

# Instale extensões do PHP necessárias para o Laravel com PostgreSQL
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libpq-dev \
    && docker-php-ext-install pdo_pgsql pgsql mbstring exif pcntl bcmath gd

# Instale o Composer (utilizando a imagem oficial do Composer)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Configure o diretório de trabalho
WORKDIR /var/www

# Copie os arquivos para o contêiner
COPY . .

# Instale as dependências do Composer
RUN composer install --optimize-autoloader --no-dev

# Configure as permissões para a pasta storage e cache
RUN chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www/storage

# Exponha a porta que o Laravel usará
EXPOSE 8000

# Comando para iniciar o Laravel
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
