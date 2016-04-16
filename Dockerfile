FROM ubuntu:14.04
MAINTAINER Eugene Greendrake (eugene@greendrake.info)

# To be able to run "top"
ENV TERM xterm

RUN \
  apt-get update -qq && \
  apt-get install -qq -y nano make wget rsync nginx telnet git net-tools php5-cli php5-fpm php5-curl php5-mysqlnd supervisor sudo php5-xdebug && \
  apt-get autoremove && \
  apt-get clean && \
  php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php && \
  php composer-setup.php --install-dir=bin --filename=composer && \
  rm -f composer-setup.php && \
  wget https://phar.phpunit.de/phpunit.phar && \
  chmod +x phpunit.phar && \
  mv phpunit.phar /usr/local/bin/phpunit

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 80
CMD ["/usr/bin/supervisord"]