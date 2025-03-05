FROM ubuntu:24.04
ENV DEBIAN_FRONTEND="noninteractive"

# Install required dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    nano \
    imagemagick \
    apache2 \
    subversion \
    ghostscript \
    antiword \
    poppler-utils \
    libimage-exiftool-perl \
    cron \
    postfix \
    wget \
    php \
    php-cli \
    php-apcu \
    php-curl \
    php-dev \
    php-gd \
    php-intl \
    php-mysqlnd \
    php-mbstring \
    php-zip \
    libapache2-mod-php \
    ffmpeg \
    libopencv-dev \
    python3-opencv \
    python3 \
    python3-pip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Configure PHP
RUN sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 100M/g" /etc/php/8.1/apache2/php.ini \
    && sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 100M/g" /etc/php/8.1/apache2/php.ini \
    && sed -i -e "s/max_execution_time\s*=\s*30/max_execution_time = 300/g" /etc/php/8.1/apache2/php.ini \
    && sed -i -e "s/memory_limit\s*=\s*128M/memory_limit = 1G/g" /etc/php/8.1/apache2/php.ini

# Apache Configuration
RUN printf '<Directory /var/www/>\n\
\tOptions FollowSymLinks\n\
</Directory>\n' >> /etc/apache2/sites-enabled/000-default.conf

# Set up cron job
COPY cronjob /etc/cron.daily/resourcespace
RUN chmod +x /etc/cron.daily/resourcespace

# Set up application
WORKDIR /var/www/html
RUN rm -f index.html \
    && svn co -q https://svn.resourcespace.com/svn/rs/releases/10.5 . \
    && mkdir -p filestore \
    && chmod 777 filestore \
    && chmod -R 777 include/

# Expose necessary ports
EXPOSE 80

# Start Apache
CMD ["apachectl", "-D", "FOREGROUND"]
