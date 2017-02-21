FROM ubuntu:16.04
MAINTAINER  Alon Strikovsky "alon.strik@gmail.com"
ENV REFRESHED_AT 2017-01-29

RUN apt-get update; apt-get install -y nginx; apt-get install -y python-dev

RUN echo 'Hi, I am in your container' \
    >/var/www/html/index.html

EXPOSE 80
