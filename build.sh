#!/bin/bash

# 获取脚本所在目录的绝对路径
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# 获取项目根目录路径
PROJECT_ROOT="$( cd "$SCRIPT_DIR/." &> /dev/null && pwd )"

# 从 app.yao 文件中读取版本号
APP_YAO_FILE="${PROJECT_ROOT}/app.yao"
if [ -f "$APP_YAO_FILE" ]; then
    VERSION=$(grep '"version":' "$APP_YAO_FILE" | sed 's/.*"version": "\(.*\)".*/\1/')
    if [ -z "$VERSION" ]; then
        echo "错误: 无法从 app.yao 文件中读取版本号"
        exit 1
    fi
else
    echo "错误: app.yao 文件不存在"
    exit 1
fi
# 如果 VERSION 仍然为空，则报错并退出
if [ -z "$VERSION" ]; then
    echo "错误: 未提供版本号。请设置 VERSION 环境变量或作为第一个参数传入。"
    exit 1
fi

# 设置变量
IMAGE_NAME="sjzsdu/yao-fabric"
IMAGE_TAG="${VERSION}"

# ... 其余脚本内容保持不变 ...

# 定义检查状态的函数
check_status() {
    if [ $? -ne 0 ]; then
        echo "错误: $1"
        exit 1
    fi
}

echo "使用版本号: ${VERSION}"

# 构建 Docker 镜像
echo "正在构建 Docker 镜像..."
docker build -t ${IMAGE_NAME}:${IMAGE_TAG} "${PROJECT_ROOT}"
check_status "Docker 镜像构建失败"

# 检查镜像是否成功创建
echo "检查镜像是否创建成功..."
docker image inspect ${IMAGE_NAME}:${IMAGE_TAG} > /dev/null 2>&1
check_status "无法找到刚刚构建的镜像"

# Docker Hub 登录
echo "正在登录到 Docker Hub..."
if [ -n "$DOCKER_USERNAME" ] && [ -n "$DOCKER_PASSWORD" ]; then
    # GitHub Actions 环境
    echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
else
    # 本地环境
    docker login
fi
check_status "Docker Hub 登录失败"

# 推送镜像到 Docker Hub
echo "正在推送镜像到 Docker Hub..."
docker push ${IMAGE_NAME}:${IMAGE_TAG}
check_status "推送镜像到 Docker Hub 失败"

# 标记并推送 latest 标签
echo "正在标记并推送 latest 标签..."
docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest
docker push ${IMAGE_NAME}:latest
check_status "推送 latest 标签失败"

echo "操作完成"
