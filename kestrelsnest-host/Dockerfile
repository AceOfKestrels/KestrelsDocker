
FROM nginx:alpine

# Install necessary packages, set up web root, clone repository, and configure permissions
# hadolint ignore=DL3018,DL3059
RUN apk add --no-cache bash git openrc busybox-suid dcron
RUN mkdir -p /var/www && \
    git clone https://github.com/AceOfKestrels/KestrelsNest /var/www && \
    sh /var/www/icon_generator/generate_icons.sh \
    chmod -R 777 /var/www
# Copy the custom NGINX configuration into the container
COPY ./kestrelsnest-host/data/nginx.conf /etc/nginx/nginx.conf
COPY ./kestrelsnest-host/data/mime.types /etc/nginx/mime.types

# Copy Pull Script into container
COPY ./kestrelsnest-host/data/update-web-page.sh /scripts/update-web-page.sh

# Make Script Executabel and add it to cron
RUN chmod 777 /scripts/update-web-page.sh && \
    echo "*/5 * * * * /scripts/update-web-page.sh > /var/log/nginx/cron.log" > /etc/crontabs/root && \
    chmod 0644 /etc/crontabs/root
# Expose HTTP and HTTPS ports
EXPOSE 80 443

# Start cron and NGINX services
CMD ["/bin/sh", "-c", "crond -f & nginx -g 'daemon off;'"]