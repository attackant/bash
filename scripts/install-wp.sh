#!/usr/bin/env bash

wp core download && wp core config --dbname=wordpress --dbuser=root --dbpass=secret

wp core install --admin_email=attackant@users.noreply.github.com --admin_password=secret --url=https://wordpress.dev --title="WP Playground" --admin_user=damian

wp plugin install --activate --force admin-menu-editor developer wp-dbmanager wordpress-seo plugin-central
