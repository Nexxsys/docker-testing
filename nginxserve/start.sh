#!/bin/bash

if [[ ! -f /etc/nginx/ssl/server.crt || ! -f /etc/nginx/ssl/server.crt ]]; t>
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/s>
fi

nginx -g 'daemon off;'
