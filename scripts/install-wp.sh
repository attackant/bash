#!/usr/bin/env bash

wp core download && wp core config --dbname=wordpress --dbuser=root --dbpass=

wp core install --admin_email=info@mindsharelabs.com --admin_password=17dNIluyfSmM --url=https://wordpress.dev --title="Mindshare Labs Dev" --admin_user=mindshare

wp plugin install --activate --force admin-menu-editor broken-link-checker developer wp-dbmanager php-browser-detection simple-history tinymce-advanced wordpress-seo plugin-central https://git.mindsharelabs.com/mindshare-labs/mindshare-client-security/repository/archive.zip https://github.com/mindsharelabs/mindshare-api/archive/master.zip
