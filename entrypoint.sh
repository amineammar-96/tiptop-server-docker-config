#!/bin/bash
echo 'hello php'

PHP_MEMORY_LIMIT=500M

php bin/console make:migration
php bin/console doctrine:migrations:migrate
php bin/console doctrine:fixtures:load
# Add any other commands here

#1 generate roles 
php bin/console app:create-default-role

#2 add tiptop store , admin and anonyme user 
php bin/console app:create-default-tiptop-company

#3 generate prizes
php bin/console app:add-prizes

#4 generate tickets
php -d memory_limit=${PHP_MEMORY_LIMIT} bin/console app:generate-tickets

#5 generate fake data
php bin/console app:generate-data

#6 generate email services
php bin/console app:generate-email-services

#7 generate email templates variables
php bin/console app:generate-email-templates-variables

#8 generate email templates
php bin/console app:generate-email-templates
# Start the Apache server
exec apache2-foreground
