FROM php:5.6-fpm

MAINTAINER "胸毛仙人" <chensk.home@qq.com>

# set timezome
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && \
    apt-get install -y git \
    unzip \
    vim \
    libfreetype6 \
    libfreetype6-dev \
    libjpeg62-turbo \
    libjpeg62-turbo-dev \
    mcrypt \
    libmcrypt4 \
    libmcrypt-dev \
    libmhash2 \
    libpng-dev \
    zlib1g-dev \
    && docker-php-ext-install zip \
    && docker-php-ext-install -j$(nproc) pdo_mysql gd \
## 安装imagick
    && curl -sS 'https://www.imagemagick.org/download/ImageMagick.tar.gz' -o imagemagick.tar.gz \
    && mkdir -p /tmp/imagemagick \
    && tar -xf imagemagick.tar.gz -C /tmp/imagemagick --strip-components=1 \
    && rm -f imagemagick.tar.gz \
    && ( \
        cd /tmp/imagemagick \
        && ./configure --prefix=/usr/local/imagemagick --with-jpeg=yes --with-png=yes \
        && make -j$(nproc) \
        && make install \
    ) \
    && rm -r /tmp/imagemagick \
    && curl -sS 'http://pecl.php.net/get/imagick-3.4.3.tgz' -o imagick.tgz \
    && mkdir -p /tmp/imagick \
    && tar -xf imagick.tgz -C /tmp/imagick --strip-components=1 \
    && rm -f imagick.tgz \
    && docker-php-ext-configure /tmp/imagick --with-imagick=/usr/local/imagemagick \
    && docker-php-ext-install /tmp/imagick \
    && rm -r /tmp/imagick \
## 安装composer	    
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer  \
    && composer self-update \
    && apt-get remove --purge curl -y \
    && apt-get clean \
    && composer config -g repo.packagist composer https://packagist.laravel-china.org 
## 安装bcmath 扩展
RUN set -x \
    && docker-php-source extract \
    && docker-php-ext-install bcmath \
    && docker-php-source delete

#COPY ./php.ini /usr/local/etc/php/
RUN mkdir -p /www
VOLUME [ "/data" ]
WORKDIR /www
