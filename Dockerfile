# 使用轻量级的 Alpine Linux 作为基础镜像
FROM sjzsdu/yao:latest

# 设置工作目录
WORKDIR /app

# 将当前目录的文件复制到容器的 /app 目录
COPY . /app

# 设置容器启动时执行的命令
CMD ["yao", "start"]
