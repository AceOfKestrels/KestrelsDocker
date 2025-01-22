FROM nginx:alpine

RUN echo "Version: 0.0.1"

# install needed pakets
RUN apk add --no-cache git

# download web site
RUN git clone https://github.com/AceOfKestrels/KestrelsNest /var/www

# delinting git artifacts
RUN rm -rf /var/www/README.md
RUN rm -rf /var/www/.gitignore
RUN rm -rf /var/www/.git

# Fixing perms
RUN chmod 777 -R /var/www

# Move NGINX Config file onto contaienr
COPY ./web-host/data/Web-Server-Config/nginx.conf /etc/nginx/nginx.conf