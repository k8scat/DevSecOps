# 基于 Nginx 的文件下载服务

## 支持的下载方式

- 认证下载，需要输入用户名和密码，例如：下载 [https://example.com/b.txt](https://example.com/b.txt)
- 开放下载，不需要进行认证，例如：下载 [https://example.com/open/a.txt](https://example.com/open/a.txt)

## 快速开始

### 配置域名

在 [docker-compose.yaml](./docker-compose.yaml) 中将 `example.com` 替换成使用的域名。

```yaml
hostname: example.com
```

### 配置 SSL 证书

#### 修改证书挂载配置

在 [docker-compose.yaml](./docker-compose.yaml) 中将 `./certs/fullchain.pem` 和 `./certs/privkey.pem` 替换成使用的证书文件和证书秘钥。

```yaml
volumes:
    - ./certs/fullchain.pem:/certs/cert.crt
    - ./certs/privkey.pem:/certs/cert.key
```

#### 生成证书（可选）

使用 [shell/cert.sh](../../shell/cert.sh)

```bash
bash generate_cert.sh example.com
```

### 配置 Basic Auth 登录认证

在 [docker-compose.yaml](./docker-compose.yaml) 中将 `youruser` 和 `yourpasswd` 替换成使用的用户名和密码。

```yaml
nginx:
  build:
    context: .
    args:
      USERNAME: yourusername
      PASSWORD: yourpassword
```

### 启动服务

```bash
make
```
