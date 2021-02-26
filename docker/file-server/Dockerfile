FROM nginx:latest

LABEL maintainer="K8sCat <k8scat@gmail.com>"

ARG USERNAME=yourusername
ARG PASSWORD=yourpassword

RUN mkdir -p /data/logs && \
sed -i 's#http://deb.debian.org#https://mirrors.aliyun.com#g' /etc/apt/sources.list && \
apt-get update && \
apt install -y apache2-utils && \
htpasswd -b -c /data/.passwdfile ${USERNAME} ${PASSWORD}
