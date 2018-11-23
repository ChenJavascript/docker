FROM php:5.6-fpm

MAINTAINER "胸毛仙人" <chensk.home@qq.com>

# set timezome
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y \
    libfreetype6 \
    libfreetype6-dev \
    libjpeg62-turbo \
    libjpeg62-turbo-dev \
    libmcrypt4 \
    libmcrypt-dev \
    libmhash2 \
    libpng-dev \
    zlib1g-dev \
    curl \
    libzip-dev \
    unzip \
    freetype2-demos \
    ghostscript

RUN pecl channel-update pecl.php.net

##安装redis扩展
RUN pecl install redis \
    &&  docker-php-ext-enable redis

##安装zip扩展
RUN pecl install zip \
    &&  docker-php-ext-enable zip

##安装zlib扩展    
RUN curl -fsSL 'http://www.zlib.net/zlib-1.2.11.tar.gz' -o zlib.tar.gz \
    && mkdir -p /tmp/zlib \
    && tar -xf zlib.tar.gz -C /tmp/zlib --strip-components=1 \
    && rm -f zlib.tar.gz \
    && ( \
        cd /tmp/zlib \
        && ./configure \
        && make -j$(nproc) \
        && make install \
    ) \
    && rm -r /tmp/zlib

## 安装composer       
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && ln -s $(composer config --global home) /root/composer \
    && composer config -g repo.packagist composer https://packagist.laravel-china.org

##安装pdo_mysql、bcmath扩展
RUN docker-php-ext-install pdo_mysql \
    && docker-php-ext-install bcmath

##安装gd扩展    
RUN docker-php-ext-configure \
    gd \
        --with-freetype-dir=/usr/include \
        --with-jpeg-dir=/usr/include \
    && docker-php-ext-install -j$(nproc) gd

##安装imagick扩展
RUN curl -sS 'https://www.imagemagick.org/download/ImageMagick.tar.gz' -o ImageMagick.tar.gz \
    && mkdir -p /tmp/imagemagick \
    && tar -xf ImageMagick.tar.gz -C /tmp/imagemagick --strip-components=1 \
    && rm -f ImageMagick.tar.gz \
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
    && rm -r /tmp/imagick

#COPY ./php.ini /usr/local/etc/php/
RUN mkdir -p /www
VOLUME [ "/data" ]
WORKDIR /www
