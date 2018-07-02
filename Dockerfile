FROM php:5.6-fpm

MAINTAINER "胸毛仙人" <chensk.home@qq.com>

# set timezome
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y && \
apt-get install -y git && \
apt-get install -y unzip && \
docker-php-ext-install -j$(nproc) pdo_mysql && \
curl -sS https://getcomposer.org/installer | php && \
mv composer.phar /usr/local/bin/composer && \
composer self-update && \
apt-get remove --purge curl -y && \
apt-get clean && \
composer config -g repo.packagist composer https://packagist.phpcomposer.com

COPY ./php.ini /usr/local/etc/php/
RUN mkdir -p /www
VOLUME [ "/data" ]
WORKDIR /www
