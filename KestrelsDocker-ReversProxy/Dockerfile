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

# Seting Labels for Container regestry
LABEL org.opencontainers.image.authors="mail@annika-keggenhoff.de"
LABEL org.opencontainers.image.source=https://github.com/AceOfKestrels/KestrelsDocker
LABEL org.opencontainers.image.licenses=Apache-2.0
LABEL org.opencontainers.image.description = "This is a Proconfigured Caddy Revers proxy that is supposed to be used with the KestrelsDocker Project"