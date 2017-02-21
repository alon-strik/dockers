FROM ubuntu

ENV src_code /code
ADD apache $src_code

RUN apt-get update \
    apt-get install -y --no-install-recommends apache2 \
                    libapache2-mod-jk curl wget

VOLUME ["/var/log/apache2"]
EXPOSE 80 443

ENTRYPOINT ["apache2ctl", "-D", "FOREGROUND"]

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 80
CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]

##CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
