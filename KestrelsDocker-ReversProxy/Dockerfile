# using official caddy alpine builder image
FROM caddy:builder-alpine AS builder

# starting build procces with Cloudflair DNS Modul
RUN caddy-builder \
    github.com/caddy-dns/cloudflare

# Using offical caddy Alpine img
FROM caddy:alpine

# Exposing Webports
EXPOSE 80 443

# Geting the custom caddy Binarys from the build container
COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# Moving Caddy Config file to Config Dir
COPY ./KestrelsDocker-ReversProxy/data/Caddyfile /etc/caddy/Caddyfile

# Setting up ENV Variabels used to cinfigure Caddyfile
ENV DNS_TOKEN=example_dns-token
ENV ADMIN_MAIL=mail@example.com
ENV WEB_ADDRESS=example.com
ENV KESTRELSNEST_HOST=http://kestrelsnest-host
ENV KESTRELSWIKI_HOST=http://kestrelwiki-host