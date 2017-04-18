FROM hypriot/rpi-alpine:3.5

MAINTAINER Hans-Christian Andersen <andersen.hc@gmail.com>

COPY bin/* /usr/local/bin/

RUN apk --update add php7 \
	php7-json \
	php7-phar \
	php7-mbstring \
	php7-openssl \
	php7-zlib \
	php7-fpm \
	curl

RUN curl -sS https://getcomposer.org/installer | php7 -- \
      --install-dir=/usr/local/bin \
      --filename=composer

RUN echo "phar.readonly = off" > /etc/php7/conf.d/phar.ini

EXPOSE 9000

CMD ["php-fpm"]
