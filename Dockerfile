# 使用轻量级的 Alpine Linux 作为基础镜像
FROM ubuntu:latest

# 安装 curl 和 bash（Alpine 默认没有这些工具）
RUN apk add --no-cache curl bash

# 安装 Yao
RUN curl -sSL https://raw.githubusercontent.com/sjzsdu/yao/refs/heads/main/get-yao.sh | bash

# 设置工作目录
WORKDIR /app

# 将当前目录的文件复制到容器的 /app 目录
COPY . /app

# 设置容器启动时执行的命令
CMD ["yao", "start"]
