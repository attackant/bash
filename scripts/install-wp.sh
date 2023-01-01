#!/usr/bin/env bash

wp core download && wp core config --dbname=wordpress --dbuser=root --dbpass=

wp core install --admin_email=damian@taggart.consulting --admin_password=secret --url=https://wordpress.dev --title="Dev Site" --admin_user=damian

wp plugin install --activate --force admin-menu-editor developer wp-dbmanager wordpress-seo plugin-central
