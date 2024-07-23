Source: https://blog.ropnop.com/docker-for-pentesters/#example-1---exploring-other-oss

Reference: https://docs.docker.com/engine/reference/commandline/run/

Github: https://github.com/Nexxsys/docker-testing

## Learnings
Adding the following to the `bashrc` or `zshrc` for quick deployment and clean-up of a 'temporary' container

```shell
impacket_mirror() {
    dirname=${PWD}
    sudo docker run  -v ${dirname}:/media --rm -it birigy/impacket
}

impacket() {
    dirname=${PWD}
    sudo docker run  -v ${dirname}:/media --rm -it evolution
}

```

It is important that the --rm -it and the docker image information is after the -v setting.  The -v setting sets your current working directory when you execute the function to mount as media.  That way you have access to your files on your host.  

## Docker Files
#### Impacket
Source from here: [https://github.com/fortra/impacket/blob/master/Dockerfile]

I added nano and vim install.  Once your build the docker container:
``` shell
sudo docker build -t evolution .
# evolution is the name of the container I used, and "." is used to process the Dockerfile in the current directory
```
Then you can run impacket (function above) to get a prompt on the container.  Once on the container simple activate the environment:
```shell
source activate
```

#### nginxserve
This will setup a port 80 and 443 listening http server for serving the files in your current directory.  When you ctrl+c out of the running server it is immediately shutdown and deleted as an active docker process.

Source from here: https://github.com/ropnop/dockerfiles/tree/master/nginxserve

```shell
sudo docker build -t nginxserve .  ## Assumes Dockerfile is in the current directory
```
### NOTE
You need to add the function to the `bashrc` or `zshrc` file to have a simple command run the docker container

```shell
nginxhere() {
     sudo docker run --rm -it -p 80:80 -p 443:443 -v ${PWD}:/srv/data nginxserve
}
```

If you example the Dockerfile you will notice I use the `ENTRYPOINT` directive that will call my `start.sh` script whenever a container is created. This start script generates a new random key and self-signed certificate in the correct location for Nginx and then starts the server.

 Let’s me browse to it over 80 and 443.  And I can browse the contents with a browser, or use curl/wget/invoke-webrequest

 REFERENCE: [https://blog.ropnop.com/docker-for-pentesters/#example-1---exploring-other-oss]

### Files
impacket-dockerfile
```docker
FROM python:3.8-alpine as compile
WORKDIR /opt
RUN apk add --no-cache git gcc musl-dev python3-dev libffi-dev openssl-dev cargo
RUN apk add nano vim
RUN python3 -m pip install virtualenv
RUN virtualenv -p python venv
ENV PATH="/opt/venv/bin:$PATH"
RUN git clone --depth 1 https://github.com/fortra/impacket.git
RUN python3 -m pip install impacket/

FROM python:3.8-alpine
COPY --from=compile /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
ENTRYPOINT ["/bin/sh"]
```

nginxserv-dockerfile
```docker
FROM nginx:stable
RUN apt-get update && apt-get install -y openssl
RUN mkdir -p /etc/nginx/ssl && mkdir -p /srv/data

COPY default.conf /etc/nginx/conf.d/
COPY start.sh /
ENTRYPOINT [ "/start.sh" ]
```

start.sh
```bash
#!/bin/bash

if [[ ! -f /etc/nginx/ssl/server.crt || ! -f /etc/nginx/ssl/server.crt ]]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.crt -subj '/CN=www.example.com' 
fi

nginx -g 'daemon off;'
```

default.conf
```bash
server {
    listen 80;
    listen 443 default_server ssl;

    server_name localhost;
    ssl_certificate /etc/nginx/ssl/server.crt;
    ssl_certificate_key /etc/nginx/ssl/server.key;


    location / {
        alias /srv/data/;
        autoindex on;

    }
}
```


## New Addition
Adding Zeek
https://hub.docker.com/r/zeek/zeek
[Read the docs](https://docs.zeek.org/en/master/)
Zeek is a passive, open-source network traffic analyzer. Many operators use Zeek as a network security monitor (NSM) to support investigations of suspicious or malicious activity. Zeek also supports a wide range of traffic analysis tasks beyond the security domain, including performance measurement and troubleshooting.
Zeek Cheat Sheet: https://github.com/corelight/zeek-cheatsheets/blob/master/Corelight-Zeek-Cheatsheets-3.0.4.pdf

```bash
sudo docker pull zeek/zeek:latest

# Once that is complete you can now mount a directory (i.e. pcaps) to use zeek

sudo docker -v run $(pwd):/mnt -it zeek/zeek sh
# This will give you shell and mount your current working directory into the docker container

# Next - example to break apart the pcap
zeek -C -r workshop-part-03-01.pcap

# bash to get root level in the container
```
