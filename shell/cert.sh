#!/bin/bash

email=$1
domain=$2
if [ -z "${email}" ] || [ -z "${domain}" ];then
	echo "usage: $0 <email> <domain>"
	exit 1
fi

# About options: docker run --rm certbot/certbot:latest -h
docker run --rm --name certbot -p 80:80 \
-v "/etc/letsencrypt:/etc/letsencrypt" \
-v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
certbot/certbot:latest certonly --standalone --agree-tos --non-interactive -m ${email} -d ${domain}
