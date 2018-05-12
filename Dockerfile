FROM ubuntu:latest
MAINTAINER dekmabot@gmail.com

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y --no-install-recommends openssh-server supervisor curl
RUN apt-get install -y --no-install-recommends mysql-client nginx composer nano cron libfontconfig1 libxrender1 ffmpeg
RUN apt-get install -y --no-install-recommends php php-fpm php-curl php-gd php-imap php-imagick php7.1-mbstring php7.1-zip php7.1-dom php-mysql
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

RUN apt-get autoremove

RUN mkdir -p /var/run/sshd /var/log/supervisor
 
RUN usermod -u 1000 www-data

ADD php-laravel.conf /etc/php/7.1/fpm/pool.d/laravel.conf
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD nginx-host.conf /etc/nginx/sites-enabled/default

WORKDIR /var/www/laravel
 
EXPOSE 22 80
 
CMD ["/usr/bin/supervisord"]
