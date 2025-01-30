# Stage 1: Build custom Caddy binary with Cloudflare DNS module
FROM caddy:builder-alpine AS builder

# Build Caddy with the Cloudflare DNS module
RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare

# Stage 2: Create the final container
FROM caddy:alpine

# Expose HTTP and HTTPS ports
EXPOSE 80 443

# Copy the custom Caddy binary from the builder stage
COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# Copy the custom Caddyfile configuration
COPY ./kestrelsdocker-reversproxy/data/Caddyfile /etc/caddy/Caddyfile

# Set environment variables used in the Caddyfile
ENV DNS_TOKEN=example_dns-token \
    ADMIN_MAIL=mail@example.com \
    WEB_ADDRESS=example.com \
    KESTRELSNEST_HOST=http://kestrelsnest-host \
    KESTRELSWIKI_HOST=http://kestrelwiki-host

# Add metadata labels for the container registry
# hadolint ignore=DL3018,DL3059
LABEL org.opencontainers.image.authors="mail@annika-keggenhoff.de"
# hadolint ignore=DL3018,DL3059
LABEL org.opencontainers.image.source="https://github.com/AceOfKestrels/KestrelsDocker"
# hadolint ignore=DL3018,DL3059
LABEL org.opencontainers.image.licenses="Apache-2.0"
# hadolint ignore=DL3018,DL3059
LABEL org.opencontainers.image.description="This is a preconfigured Caddy reverse proxy for the KestrelsDocker project."