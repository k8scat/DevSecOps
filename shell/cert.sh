#!/bin/bash

domain=$1
if [ -z "${domain}" ];then
	echo "usage: $0 domain"
	exit 1
fi

docker run --rm --name certbot -p 80:80 \
-v "/etc/letsencrypt:/etc/letsencrypt" \
-v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
certbot/certbot certonly --standalone --agree-tos --non-interactive -m contact@aicoder.io -d ${domain}