# Usar uma imagem oficial do PHP com o Apache
FROM php:8.1-apache

# Instalar extens�es PHP essenciais
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zlib1g-dev \
    git \
    unzip \
    libicu-dev \
    libxml2-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql mbstring ctype iconv bcmath opcache

# Instalar o Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Definir o diret�rio de trabalho
WORKDIR /var/www/html

# Copiar o c�digo da aplica��o para o container
COPY . .

# Instalar as depend�ncias do Laravel (via Composer)
RUN composer install --optimize-autoloader --no-dev

# Definir as permiss�es para os diret�rios de armazenamento
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Expor a porta 80 (padr�o do Apache)
EXPOSE 80

# Definir o comando para iniciar o Apache
CMD ["apache2-foreground"]
