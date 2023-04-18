FROM composer:lts as composer

WORKDIR /source

COPY . .

RUN composer install -n -o --no-dev --optimize-autoloader

FROM node:lts-slim as node

WORKDIR /source

COPY --from=composer /source/vendor ./vendor
COPY --from=composer /source/bootstrap ./bootstrap

COPY package.* ./
RUN npm install

COPY . .
RUN npm run build

FROM joseluisq/php-fpm:8.2 as production

WORKDIR /var/www/html

ADD . .
RUN chown -R www-data:www-data /var/www/html
COPY ./php/conf.d /usr/local/etc/php/conf.d

COPY --from=composer /source/vendor ./vendor
COPY --from=node /source/bootstrap ./bootstrap
COPY --from=node /source/public ./public