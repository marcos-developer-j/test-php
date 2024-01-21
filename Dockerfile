# Utiliza la imagen oficial de PHP con Apache
FROM php:7.4-apache

# Copia los archivos necesarios al contenedor
COPY . /var/www/html/

# Instala las dependencias de PHP y otras herramientas que puedas necesitar
RUN apt-get update && \
    apt-get install -y \
        libpq-dev \
        libzip-dev \
        unzip \
    # Agrega aquí las dependencias que puedas necesitar \
    && rm -rf /var/lib/apt/lists/* \
    && a2enmod rewrite
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer  
# Instala las dependencias de Composer


RUN docker-php-ext-install mysqli pdo_mysql zip
# Configura el servidor Apache (puedes personalizar según tus necesidades)
RUN a2enmod rewrite

# Copia tu configuración personalizada del sitio virtual
COPY apache-config.conf /etc/apache2/sites-available/000-default.conf
WORKDIR /var/www/html
RUN composer install --no-cache

# Exponer el puerto en el que Apache escuchará
EXPOSE 80
RUN
# Comando para iniciar el servidor Apache al ejecutar el contenedor
CMD ["apache2-foreground"]
