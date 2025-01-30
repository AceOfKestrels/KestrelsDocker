
FROM nginx:alpine

# Install necessary packages, set up web root, clone repository, and configure permissions
# hadolint ignore=DL3018,DL3059
RUN apk add --no-cache bash git openrc busybox-suid dcron
RUN mkdir -p /var/www && \
    git clone https://github.com/AceOfKestrels/KestrelsNest /var/www && \
    chmod -R 777 /var/www && \
    echo "*/5 * * * * cd /var/www && git pull origin main && chmod -R 777 /var/www" > /etc/crontabs/root && \
    chmod 0644 /etc/crontabs/root

# Copy the custom NGINX configuration into the container
COPY ./kestrelsnest-host/data/nginx.conf /etc/nginx/nginx.conf
COPY ./kestrelsnest-host/data/mime.types /etc/nginx/mime.types


# Expose HTTP and HTTPS ports
EXPOSE 80 443

# Start cron and NGINX services
CMD ["/bin/sh", "-c", "crond -f & nginx -g 'daemon off;'"]