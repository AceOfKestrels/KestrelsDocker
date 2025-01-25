FROM nginx:alpine

RUN echo "Version: 0.0.3"

# install needed pakets
RUN apk add --no-cache  bash git openrc busybox-suid dcron

# download and prep web root and git repo
RUN mkdir -p /var/www
RUN git clone https://github.com/AceOfKestrels/KestrelsNest /var/www

# Fixing perms on web root
RUN chmod 777 -R /var/www


# settingup cronjob to regularly pull repo
RUN echo "*/5 * * * * cd /var/www && git pull origin main && chmod -R 777 /var/www" > /etc/crontabs/root

# Fixing perms on the crontab file
RUN chmod 0644 /etc/crontabs/root

# Move NGINX Config file onto contaienr
COPY ./kestrelsnest-host/data/Web-Server-Config/nginx.conf /etc/nginx/nginx.conf

# Expose HTTP and HTTPS ports
EXPOSE 80 443

# Start both cron and NGINX services
CMD ["/bin/sh", "-c", "crond -f & nginx -g 'daemon off;'"]

# Seting Labels for Container regestry
LABEL org.opencontainers.image.authors="mail@annika-keggenhoff.de"
LABEL org.opencontainers.image.source=https://github.com/AceOfKestrels/KestrelsDocker
LABEL org.opencontainers.image.licenses=Apache-2.0
LABEL org.opencontainers.image.description = "This is a Proconfigured NGINX Web Server that is supposed to be used with the KestrelsDocker Project"