FROM alpine:latest

# install needed pakets
RUN apk add --no-cache nginx git

# download web site
RUN git clone https://github.com/AceOfKestrels/KestrelsNest /tmp/site

# delinting git artifacts
RUN rm -rf /tmp/site/README.md
RUN rm -rf /tmp/site/.gitignore
RUN rm -rf /tmp/site/.git

# cleaning up web root
RUN rm -rf  /var/www/*

# Moving Website to web root
RUN cp /tmp/site/* /var/www/ -R

# Move NGIX Config file onto contaienr
COPY ./web-host/data/Web-Server-Config/default /etc/nginx/

#exposing ports
EXPOSE 80/tcp
EXPOSE 80/udp

CMD ["nginx", "-g", "daemon off;"]
