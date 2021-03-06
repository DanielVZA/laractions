FROM php:8.0-fpm-buster

RUN apt-get update -y && apt-get install -y zip unzip git vim libpq-dev

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql
RUN docker-php-ext-install pdo pdo_pgsql pgsql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /app

COPY . /app

RUN composer install --optimize-autoloader --no-dev

CMD php artisan serve --host=0.0.0.0 --port $PORT

EXPOSE $PORT