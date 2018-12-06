FROM ubuntu:18.04
MAINTAINER  momo@whitecrow.com.cn

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get clean && apt-get -y update && \
                apt-get install -y software-properties-common && \
                add-apt-repository ppa:ondrej/nginx-mainline &&  \
                apt-get -y update &&  \
                apt-get install -y --force-yes --no-install-recommends locales curl git tzdata \
                php7.2-bcmath php7.2-bz2 php7.2-cli php7.2-common php7.2-curl \
                php7.2-cgi php7.2-dev php7.2-fpm php7.2-gd php7.2-g php7.2-imap php7.2-intl \
                php7.2-json php7.2-ldap php7.2-mbstring php7.2-mysql \
                php7.2-odbc php7.2-opcache php7.2-pgsql php7.2-phpdbg php7.2-pspell \
                php7.2-readline php7.2-recode php7.2-soap php7.2-sqlite3 \
                php7.2-tidy php7.2-xml php7.2-xmlrpc php7.2-xsl php7.2-zip \
                php-yac php7.2-imap php-tideways php-mongodb && \
                apt-get clean && rm -rf /var/lib/apt/lists/*

RUN sed -i "s/display_errors = Off/display_errors = On/" /etc/php/7.2/fpm/php.ini && \
                #sed -i "s/upload_max_filesize = .*/upload_max_filesize = 32M/" /etc/php/7.2/fpm/php.ini && \
                #sed -i "s/post_max_size = .*/post_max_size = 64M/" /etc/php/7.2/fpm/php.ini &&  \
                sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.2/fpm/php.ini &&  \
                sed -i -e "s/pid =.*/pid = \/var\/run\/php7.2-fpm.pid/" /etc/php/7.2/fpm/php-fpm.conf && \
                sed -i -e "s/error_log =.*/error_log = \/proc\/self\/fd\/2/" /etc/php/7.2/fpm/php-fpm.conf && \
                sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php/7.2/fpm/php-fpm.conf && \
                sed -i "s/listen = .*/listen = 9000/" /etc/php/7.2/fpm/pool.d/www.conf && \
                sed -i "s/;catch_workers_output = .*/catch_workers_output = yes/" /etc/php/7.2/fpm/pool.d/www.conf


RUN curl https://getcomposer.org/installer > composer-setup.php && php composer-setup.php && mv composer.phar /usr/local/bin/composer && rm composer-setup.php && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /var/www/html

EXPOSE 9000
CMD ["php-fpm7.2"]
