ARG PHP_VERSION=7.1
FROM php:${PHP_VERSION}

ENV COMPOSER_HOME=/var/lib/composer
WORKDIR /opt/app

RUN apt-get update -y && \
    apt-get install -y git zip zlib1g-dev libfreetype6-dev libjpeg62-turbo-dev && \
    pecl install xdebug-2.5.0 && \
    docker-php-ext-install -j$(nproc) zip gd && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-enable xdebug && \
    curl -sS https://getcomposer.org/installer \
    | php -- --install-dir=/usr/local/bin --filename=composer

ENTRYPOINT ["./build.sh" ]
