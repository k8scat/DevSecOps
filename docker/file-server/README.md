# 基于 Nginx 的文件下载服务

## 配置 SSL 证书

### 生成证书

使用 [shell/cert.sh](../../shell/cert.sh)

```bash
bash cert.sh example.com
```

### 拷贝证书

```bash
sudo cp /etc/letsencrypt/live/example.com/fullchain.pem ./certs/
sudo cp /etc/letsencrypt/live/example.com/privkey.pem ./certs/
sudo chown k8scat:k8scat ./certs/fullchain.pem
sudo chown k8scat:k8scat ./certs/privkey.pem
```

## 配置 Basic Auth 登录认证

### 安装 httpd-tools

```bash
yum install httpd-tools -y
```

### 创建授权用户和密码

```bash
htpasswd -c .passwdfile k8scat
```

## 启动服务

```bash
docker-compose up -d
```

## 下载方式

- 认证下载 [https://example.com/b.txt](https://example.com/b.txt)
- 开放下载 [https://example.com/open/a.txt](https://example.com/open/a.txt)
