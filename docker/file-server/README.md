# 基于 Nginx 和 Docker 的文件下载服务器

## 功能点

存放在 `/path/to/your/files` 目录下的文件可以被下载。

- 查看文件列表，例如：访问 [https://example.com/files](https://example.com/files)
- `/path/to/your/files` 目录下的文件需要认证下载，即需要输入用户名和密码，例如：下载 [https://example.com/files/a.txt](https://example.com/files/a.txt)
- `/path/to/your/files/open` 目录下的文件不需要进行认证即可下载，例如：下载 [https://example.com/download/b.txt](https://example.com/download/b.txt)

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

### 设置文件存储目录

在 [docker-compose.yaml](./docker-compose.yaml) 中将 `/path/to/your/files` 替换成使用的文件存储目录。

```yaml
volumes:
    - /path/to/your/files:/files
```

### 启动服务

```bash
make
```
