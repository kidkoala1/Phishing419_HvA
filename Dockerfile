FROM debian:latest

RUN apt-get update && apt-get install -y apache2 \
libapache2-mod-wsgi-py3 \ 
python3 

#RUN apt-get install -y python3-mysql.connector

# RUN apt-get install -y python3-pip
# RUN pip3 install mysql-connector-python

RUN apt-get install -y  default-libmysqlclient-dev
RUN apt-get install -y python3-mysqldb && apt install -y python3-pip
RUN pip3 install  mysqlclient
RUN pip3 install mysql-connector-python

# Copy over the apache configuration file and enable the site
COPY ./TP.conf /etc/apache2/sites-available/TP.conf

# verwijdert stock html pagina
RUN rm /var/www/html/index.html


RUN mkdir /var/www/TP
RUN mkdir /var/www/TP/html
RUN mkdir /var/www/TP/wsgi
COPY ./public_html/ /var/www/TP/html/
COPY ./Python /var/www/TP/wsgi/

RUN chown www-data:www-data /var/www/TP/wsgi/
RUN chmod 755 /var/www/TP/wsgi/
RUN a2dissite 000-default
RUN a2ensite TP
RUN service apache2 restart


EXPOSE 80

WORKDIR /var/

CMD  /usr/sbin/apache2ctl -D FOREGROUND
