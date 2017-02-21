# LMS frontend Dockerfile
FROM ubuntu

ENV code_root /code
ENV www_root /code/www

# Install.
RUN \
  apt-get update && \
  apt-get install -y curl wget apache2 ntp

# Set environment variables.
ENV web_files ${www_root}/html

# Add files make the /code folder available in the docker image
ADD . $code_root

#
RUN ln -sf /dev/stdout /var/log/apache2/access.log
RUN ln -sf /dev/stderr /var/log/apache2/error.log

#Create directory for apache2 lock file and run directory
RUN mkdir -p /var/lock/apache2 /var/run/apache2

#Set required environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2
ENV LANG C

EXPOSE 80
CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
