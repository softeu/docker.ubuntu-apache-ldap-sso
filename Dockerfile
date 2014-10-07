FROM ubuntu:14.04


RUN echo "1.565.1" > .lts-version-number

RUN apt-get update && apt-get install -y wget git curl zip vim
RUN apt-get update && apt-get install -y apache2 


RUN usermod -U www-data && chsh -s /bin/bash www-data


#RUN echo 'ServerName ${SERVER_NAME}' >> /etc/apache2/conf-enabled/servername.conf

#COPY enable-var-www-html-htaccess.conf /etc/apache2/conf-enabled/
COPY run_apache.sh /var/www/

COPY loglevel.conf /etc/apache2/conf-enabled/

RUN a2enmod rewrite proxy headers ldap authnz_ldap proxy_http

#RUN mkdir -p /etc/apache2/conf-dockerized /etc/apache2/sites-dockerized
#RUN echo "IncludeOptional conf-dockerized/*.conf" > /etc/apache2/conf-enabled/include-dockerized.conf
#RUN echo "IncludeOptional sites-dockerized/*.conf" > /etc/apache2/sites-enabled/include-dockerized.conf


#VOLUME ["/var/www/html", "/var/log/apache2",  "/etc/apache2/sites-enabled/"]

ENV SERVER_NAME docker-apache-ldap-sso


EXPOSE 80

WORKDIR /var/www/html
MAINTAINER Jindrich Vimr <jvimr@softeu.com>

CMD ["/var/www/run_apache.sh"]

