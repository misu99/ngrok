[![Build
status](https://travis-ci.org/inconshreveable/ngrok.svg)](https://travis-ci.org/inconshreveable/ngrok)

# ngrok - Introspected tunnels to localhost ([homepage](https://ngrok.com))
### ”I want to expose a local server behind a NAT or firewall to the internet.”
![](https://ngrok.com/static/img/overview.png)

## What is ngrok?
ngrok is a reverse proxy that creates a secure tunnel from a public endpoint to a locally running web service.
ngrok captures and analyzes all traffic over the tunnel for later inspection and replay.

## Requirements

Go version >= 1.11

## Build

- ```
  git clone https://github.com/misu99/ngrok.git
  cd ngrok
  
  # 服务端
  GOOS=linux GOARCH=amd64 make release-server
  
  # 客户端
  # 32位linux客户端: 
  GOOS=linux GOARCH=386 make release-client
  
  # 64位linux客户端: 
  GOOS=linux GOARCH=amd64 make release-client
  
  #32位windows客户端: 
  GOOS=windows GOARCH=386 make release-client
  
  #64位windows客户端: 
  GOOS=windows GOARCH=amd64 make release-client
  
  #32位mac平台客户端:
  GOOS=darwin GOARCH=386 make release-client
  
  #64位mac平台客户端:
  GOOS=darwin GOARCH=amd64 make release-client
  
  #ARM平台linux客户端: 
  GOOS=linux GOARCH=arm make release-client
  ```

## Improve

- 服务端增加启动参数authtoken进行连接认证，避免陌生人使用你的代理服务。  
  - 服务端启动如：```./ngrokd -domain=ngrok.xxx.com -authtoken=123456```  
  - 客户端配置文件增加参数：  ```auth_token: 123456```  
  
    ```
    server_addr: ngrok.xxx.com:4443
    trust_host_root_certs: true
    auth_token: 123456
    tunnels:
      http:
        subdomain: "test"
        proto:
          http: "8080"
      https:
        subdomain: "test"
        proto:
          https: "8080"
    ```

- 摒弃 GOPATH 包管理方式，改用 Go Module 包管理，使用 https://goproxy.io 代理加速依赖包下载。

- 增加 docker 编排配置，便于服务端的部署。

## Docker

- 使用已经编译好的docker镜像，具体使用参数详见docker hub仓库。  
[docker镜像仓库](https://hub.docker.com/r/misu999/ngrokd)

- 如需手动编译docker镜像，请进入docker目录，使用Dockerfile或者docker-compose.yml进行编译。  
推荐使用docker-compose编排工具。
