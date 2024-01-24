FROM alpine:3.18
ARG PHP_VERSION=82 \
    DB_NAME \
    DB_USER \
    DB_PASS \
    WP_ADMIN \
    WP_ADMIN_PASS \
    WP_ADMIN_EMAIL \
    WP_USER \
    WP_USER_EMAIL

ENV DB_NAME=${DB_NAME}
ENV DB_PASS=${DB_PASS}
ENV DB_USER=${DB_USER}
ENV WP_ADMIN=${WP_ADMIN}
ENV WP_ADMIN_PASS=${WP_ADMIN_PASS}
ENV WP_ADMIN_EMAIL=${WP_ADMIN_EMAIL}
ENV WP_USER=${WP_USER}
ENV WP_USER_EMAIL=${WP_USER_EMAIL}
 
RUN apk update && apk upgrade && apk add --no-cache \
    php${PHP_VERSION} \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysqli \
    php${PHP_VERSION}-json \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-exif \
    php${PHP_VERSION}-fileinfo \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-openssl \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-redis \
    php${PHP_VERSION}-phar \
    php${PHP_VERSION}-gd \
    wget \
    unzip && \
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
      /etc/php82/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" \
      /etc/php82/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" \
      /etc/php82/php-fpm.d/www.conf && \
    rm -f /var/cache/apk/*

WORKDIR /var/www
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    php82 wp-cli.phar --info && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/bin/wp && \
    ln -s /usr/bin/php82 /usr/bin/php && \
    wp --info

COPY requirements/wordpress/conf/startwp.sh /usr/bin/
RUN chmod +x /usr/bin/startwp.sh
#CMD /usr/bin/starwp.sh
ENTRYPOINT ["sh", "/usr/bin/startwp.sh"]
