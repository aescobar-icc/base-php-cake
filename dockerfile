FROM php:7.3-fpm-bullseye

ENV COMPOSE_VERSION="2.3.5"
#ENV CAKEPHP_VERSION="4.3.0"
ENV CAKEPHP_VERSION="3.6"

RUN apt-get update && \
	apt-get install -y zip unzip procps acl \
	# for envsubst
	gettext-base  \
	# for php-intl
	libicu-dev \
	#postgres
	libpq-dev \
	#ext-zip
	libzip-dev \
	#libpng
	libpng-dev \
	#cron
	rsyslog cron

# install php-intl
RUN	docker-php-ext-configure intl
RUN docker-php-ext-install intl

# Install Postgre PDO
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql
RUN docker-php-ext-install pdo pdo_pgsql pgsql

# Install ext-zip
RUN docker-php-ext-configure zip
RUN docker-php-ext-install zip

# Install gd
RUN docker-php-ext-configure gd
RUN docker-php-ext-install gd

COPY . /opt/base-php-cake
WORKDIR /opt/base-php-cake

RUN bash install-composer.sh
RUN bash install-phpcake.sh


# WORKDIR /usr/src/myapp
#CMD composer -vvv about
#CMD bash  run_infinity.sh

#USER www-data
CMD bash /opt/base-php-cake/run.sh