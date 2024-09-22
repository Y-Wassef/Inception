FROM debian:bullseye

RUN apt-get -y update && apt-get install -y \
    curl \
    wget \
    unzip \
    less \
    php \
    php-fpm \
    php-mysql \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html

COPY ./tools/wordpress-setup.sh /usr/local/bin/wordpress-setup.sh
RUN chmod +x /usr/local/bin/wordpress-setup.sh

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Create the directory for the PHP-FPM socket
RUN mkdir -p /run/php

RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wordpress-setup.sh"]

CMD ["php-fpm7.4", "--nodaemonize"]
