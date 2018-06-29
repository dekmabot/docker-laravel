FROM ubuntu:latest
MAINTAINER dekmabot@gmail.com

# System
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y --no-install-recommends openssh-server supervisor curl software-properties-common
RUN apt-get install -y --no-install-recommends mysql-client nginx composer nano cron libfontconfig1 libxrender1 ffmpeg

# php 7.2
RUN add-apt-repository ppa:ondrej/php -y
RUN apt-get update && apt-get upgrade -y --allow-unauthenticated
RUN apt-get install -y --allow-unauthenticated --no-install-recommends php7.2-common php7.2-cli php7.2-fpm php7.2-curl php7.2-gd php7.2-mysql php7.2-mbstring php7.2-dom php7.2-zip php-imap php-imagick zip unzip

RUN apt-get autoremove

RUN mkdir -p /var/run/sshd /var/log/supervisor
 
RUN usermod -u 1000 www-data

ADD php-laravel.conf /etc/php/7.1/fpm/pool.d/laravel.conf
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD nginx-host.conf /etc/nginx/sites-enabled/default

WORKDIR /var/www/laravel
 
EXPOSE 22 80
 
CMD ["/usr/bin/supervisord"]
