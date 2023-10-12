# Utilizamos una imagen base con PHP 8 y Apache
FROM php:8-apache

# Actualiza el sistema y establece variables de entorno
RUN apt-get update
ENV DEBIAN_FRONTEND=noninteractive

# Instala extensiones de PHP requeridas por Laravel
RUN docker-php-ext-install pdo pdo_mysql mbstring

# Instala Node.js y npm
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

# Instala Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Configura y habilita el módulo Apache de reescritura
RUN a2enmod rewrite

# Configura la base de datos MySQL
ENV MYSQL_ROOT_PASSWORD=your_root_password
ENV MYSQL_DATABASE=your_database_name
ENV MYSQL_USER=your_mysql_user
ENV MYSQL_PASSWORD=your_mysql_password

# Copia los archivos de tu aplicación Laravel al contenedor
COPY . /var/www/html

# Define el directorio de trabajo
WORKDIR /var/www/html

# Instala las dependencias de PHP y Node.js
RUN composer install
RUN npm install

# Expone el puerto 80 para el servidor Apache
EXPOSE 80

# Inicia el servidor Apache
CMD ["apache2-foreground"]