# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lmushroo <lmushroo@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/16 22:06:19 by lmushroo          #+#    #+#              #
#    Updated: 2021/02/18 06:52:42 by lmushroo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install vim curl wget tar unzip
RUN apt-get -y install openssl
RUN apt-get -y install nginx
RUN apt-get -y install mariadb-server
RUN apt-get -y install php-fpm php-mbstring php-gettext php-mysql \
php-curl php-gd php-intl php-soap php-xml php-xmlrpc php-zip
RUN curl -LO https://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.zip
RUN unzip phpMyAdmin-5.0.4-all-languages.zip

RUN mv phpMyAdmin-5.0.4-all-languages ./var/www/html/phpMyAdmin
RUN mv wordpress ./var/www/html/wordpress

COPY ./srcs/default ./etc/nginx/sites-available/default
COPY ./srcs/default ./etc/nginx/sites-enabled/default
COPY ./srcs/wp-config.php /var/www/html/wordpress/wp-config.php
COPY ./srcs/config.inc.php /var/www/html/phpMyAdmin/config.inc.php
COPY ./srcs/usefull.sh .

EXPOSE 80 443

CMD bash usefull.sh