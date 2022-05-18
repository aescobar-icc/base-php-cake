#!/bin/bash

APP_PATH=/var/www/cake-app

if [ ! -d $APP_PATH/vendor ]; then
	mkdir -p $APP_PATH/vendor
fi

if [ -z "$(ls -A $APP_PATH/vendor)" ]; then
	cd $APP_PATH
	composer install
else
	echo "INFO: vendor is not empty"
fi

echo "starting cron service"
rsyslogd
service cron start

php-fpm
