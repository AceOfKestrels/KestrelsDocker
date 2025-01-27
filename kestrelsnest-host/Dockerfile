FROM nginx:alpine

# Set metadata labels for the image
LABEL org.opencontainers.image.authors="mail@annika-keggenhoff.de" \
      org.opencontainers.image.source="https://github.com/AceOfKestrels/KestrelsDocker" \
      org.opencontainers.image.licenses="Apache-2.0" \
      org.opencontainers.image.description="This is a preconfigured NGINX web server for the KestrelsDocker project."

# Echo the version for documentation purposes
RUN echo "Version: 0.1.0"

# Install necessary packages, set up web root, clone repository, and configure permissions
RUN apk add --no-cache bash=5.2.37-r0 git=2.48.1-r0 openrc=0.56-r0 busybox-suid=1.37.0-r13 dcron=4.6-r0 && \
    mkdir -p /var/www && \
    git clone https://github.com/AceOfKestrels/KestrelsNest /var/www && \
    chmod -R 777 /var/www && \
    echo "*/5 * * * * cd /var/www && git pull origin main && chmod -R 777 /var/www" > /etc/crontabs/root && \
    chmod 0644 /etc/crontabs/root

# Copy the custom NGINX configuration into the container
COPY ./kestrelsnest-host/data/Web-Server-Config/nginx.conf /etc/nginx/nginx.conf

# Expose HTTP and HTTPS ports
EXPOSE 80 443

# Start cron and NGINX services
CMD ["/bin/sh", "-c", "crond -f & nginx -g 'daemon off;'"]
