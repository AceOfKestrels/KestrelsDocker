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