FROM debian:latest

# File Author / Maintainer
MAINTAINER Jakub Banaszak

RUN apt-get update && apt-get install -y apache2 \
libapache2-mod-wsgi-py3 \ 
python3 

#RUN apt-get install -y python3-mysql.connector

# RUN apt-get install -y python3-pip
# RUN pip3 install mysql-connector-python

RUN apt-get install -y  default-libmysqlclient-dev
RUN apt-get install -y python-mysqldb && apt install -y python3-pip
RUN pip3 install  mysqlclient
RUN pip3 install mysql-connector-python

# Copy over the apache configuration file and enable the site
COPY ./PAD.conf /etc/apache2/sites-available/PAD.conf

# verwijdert stock html pagina
RUN rm /var/www/html/index.html


RUN mkdir /var/www/pad
RUN mkdir /var/www/pad/html
RUN mkdir /var/www/pad/wsgi
COPY ./public_html/ /var/www/pad/html/
COPY ./Python /var/www/pad/wsgi/

RUN chown www-data:www-data /var/www/pad/wsgi/
RUN chmod 755 /var/www/pad/wsgi/
RUN a2dissite 000-default
RUN a2ensite PAD
RUN service apache2 restart


EXPOSE 80

WORKDIR /var/

CMD  /usr/sbin/apache2ctl -D FOREGROUND
