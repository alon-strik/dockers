# LMS frontend Dockerfile
FROM ubuntu

ENV code_root /code
ENV www_root /code/www

# Install.
RUN \
  apt-get update && \
  apt-get install -y curl wget apache2

# Set environment variables.
ENV web_files ${www_root}/html/admin

# Add files make the /code folder available in the docker image
ADD . $code_root

EXPOSE 80
CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
