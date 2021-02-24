FROM nginx:latest

LABEL maintainer="K8sCat <k8scat@gmail.com>"
LABEL version="1.0.0"

ARG USERNAME=yourusername
ARG PASSWORD=yourpassword

RUN mkdir -p /data && \
sed -i 's#http://deb.debian.org#https://mirrors.aliyun.com#g' /etc/apt/sources.list && \
apt update -y && \
apt install -y apache2-utils && \
htpasswd -b -c /data/.passwdfile ${USERNAME} ${PASSWORD} && \
apt remove -y apache2-utils
