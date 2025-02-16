# KestrelsDocker

## Description
this is the deployment for the  [kestrelsnest.gg](https://kestrelsnest.gg/) website
the website consists of the following projects:
- [KestrelsNest](https://github.com/AceOfKestrels/KestrelsNest) The Main Page and the Templates to display the wiki pages
- [KestrelsWiki](https://github.com/AceOfKestrels/KestrelsWiki) The API That Provides the wiki Content

## Deployment
### Prerequisites

- setup a x86 or arm64 system
- Install Docker on the system

### Docker Compose

- Create A Folder and enter it
    ```Bash
        mkdir KestrelsDocker
        cd KestrelsDocker
    ```
  
- Download the Docker Compose File
    ```Bash
        wget https://raw.githubusercontent.com/AceOfKestrels/KestrelsDocker/refs/heads/main/docker-compose.yml
    ```
- Create a .env File and out copy the following content into it and fill out the data nedded
    ```dotenv
        # Revers Proxy Config
        CLOUDFLARE_TOKEN=YourDNSToken #your cloudflair dns token with zone edit rights for the used domain
        ADMIN_EMAIL=your-mail@example.com #the mail on wich the SSL Certs are Bound
        WEB_ADRESS=example.com #the web adress of the frontend

        # Kestrels Wiki Config
        CONTENT_GIT_REPOSITORY=https://github.com/aceofkestrels/brain.git
        
    ```

- Start the Project
    ```Bash
        docker compose up
    ```


## Dependency's used

### in the [KestrelsNest](https://github.com/AceOfKestrels/KestrelsNest) Host
- [NGINX](https://hub.docker.com/_/nginx)
- [DCron](https://github.com/dubiousjim/dcron)

### in the KestrelsDocker ReversProxy
- [Caddy](https://hub.docker.com/_/caddy/)
- [Cloudflare module](https://github.com/caddy-dns/cloudflare) for Caddy

### in the [KestrelsWiki](https://github.com/AceOfKestrels/KestrelsWiki) Host
- [ASP.Net](https://learn.microsoft.com/en-us/aspnet/core/host-and-deploy/docker/building-net-docker-images?view=aspnetcore-9.0#aspnet-core-docker-images)
  
