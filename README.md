# KestrelsDocker

## Description
this is the deployment for the  [kestrelsnest.gg](https://kestrelsnest.gg/) website
the website consists of the following projects:
- [KestrelsNest](https://github.com/AceOfKestrels/KestrelsNest) The Main Page and the Templates to display the wiki pages
- [KestrelsWiki](https://github.com/AceOfKestrels/KestrelsWiki) The API That Provides the wiki Content

## Deployment
TODO

## Dependency's used

### in the KestrelsNest Host
- [NGINX](https://hub.docker.com/_/nginx)
- [DCron](https://github.com/dubiousjim/dcron)

### in the KestrelsDocker ReversProxy
- [Caddy](https://hub.docker.com/_/caddy/)
- [Cloudflare module](https://github.com/caddy-dns/cloudflare) for Caddy
  