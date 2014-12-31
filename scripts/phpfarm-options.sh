# rename this to custom-options.sh in the phpfarm/src directory 
# before compiling with phpfarm


configoptions="\
--with-libdir=/usr \
--with-mysql=/usr
--with-mysqli=/usr/bin/mysql/bin/mysql_config \
--with-pdo_mysql=/usr/bin/mysql \
--with-regex=php \
--with-bz2 \
--enable-ctype \
--without-gdbm \
--with-iconv \
--enable-shmop \
--with-libxml-dir=/usr \
--with-kerberos=/usr \
--enable-pdo \
--with-curl \
--enable-bcmath \
--with-gd \
--with-zlib-dir=/usr \
--with-gettext=/usr \
--with-mcrypt=/usr \
--with-mhash \
--with-tidy \
--enable-wddx \
--with-xsl=/usr \
--enable-debug \
--disable-short-tags \
--without-pear \
--enable-calendar \
--enable-exif \
--enable-ftp \
--enable-mbstring \
--enable-pcntl \
--enable-soap \
--enable-sockets \
--enable-sqlite-utf8 \
--enable-wddx \
--enable-zip \
--with-zlib \
--with-gettext \
--with-jpeg-dir=/usr \
"
