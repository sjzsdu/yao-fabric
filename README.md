# YAO Fabric

基于YAO框架开发的业务系统，集成了CRM、知识库等功能模块，提供高效的企业管理解决方案。

## 功能特性

- **CRM管理**
  - 公司管理：记录和管理客户公司信息
  - 人员管理：管理客户联系人信息
  - 跟进记录：跟踪客户互动和商机进展
  - 客户池：统一管理潜在客户资源

- **知识库系统**
  - 文档管理：集中存储和管理企业文档
  - 仪表盘：可视化展示知识库使用情况

- **产品管理**
  - 面料管理：专业的面料产品信息管理
  - 分类管理：灵活的产品分类体系
  - 批量导入：支持产品数据批量导入

- **系统管理**
  - 员工管理：管理系统用户账号和权限
  - 部门管理：维护企业组织架构
  - 角色权限：灵活的RBAC权限控制

## 技术架构

- 基于YAO低代码开发框架
- MySQL数据库
- OpenAI集成支持
- 腾讯云对象存储（COS）
- Docker容器化部署

## 快速开始

### 环境要求

- MySQL 5.7+
- YAO Framework
- Docker (可选)

### 安装部署

1. 克隆项目代码

```bash
git clone https://github.com/sjzsdu/yao-fabric
cd yao-fabric
```

2. 配置环境变量

```bash
cp .env-template .env
```

编辑.env文件，配置以下必要参数：
- 数据库连接信息
- OpenAI API密钥
- 腾讯云COS配置

3. 初始化数据库

```bash
mysql -u root -p < database.sql
```

4. 启动服务

```bash
yao start
```

### Docker部署

```bash
docker-compose up -d
```

## 使用说明

1. 访问系统
   - 管理后台：http://localhost:5099/admin/
   - Studio开发工具：http://localhost:5077

2. 默认管理员账号
   - 用户名：admin
   - 密码：请参考数据库初始化脚本

## 开发指南

### 目录结构

```
├── apis/          # API接口定义
├── charts/        # 图表配置
├── flows/         # 业务流程
├── forms/         # 表单定义
├── models/        # 数据模型
├── tables/        # 数据表格
└── scripts/       # 业务脚本
```

### 开发流程

1. 定义数据模型（models/）
2. 配置业务接口（apis/）
3. 开发页面组件（forms/, tables/）
4. 实现业务逻辑（flows/, scripts/）

## 许可证

[待补充]

## 贡献指南

欢迎提交Issue和Pull Request。