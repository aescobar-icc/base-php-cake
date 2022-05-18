#!/bin/sh

envsubst "`printf '${%s} ' $(sh -c "env|cut -d'=' -f1")`" < composer.temp.json > composer.json
composer install
