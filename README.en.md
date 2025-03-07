# YAO Fabric

A comprehensive business system developed with the YAO framework, integrating CRM, knowledge base, and other functional modules to provide efficient enterprise management solutions.

## Features

- **CRM Management**
  - Company Management: Record and manage customer company information
  - Contact Management: Manage customer contact information
  - Follow-up Records: Track customer interactions and business opportunities
  - Customer Pool: Unified management of potential customer resources

- **Knowledge Base System**
  - Document Management: Centralized storage and management of enterprise documents
  - Dashboard: Visual display of knowledge base usage

- **Product Management**
  - Fabric Management: Professional fabric product information management
  - Category Management: Flexible product classification system
  - Batch Import: Support for bulk product data import

- **System Management**
  - Staff Management: Manage system user accounts and permissions
  - Department Management: Maintain enterprise organizational structure
  - Role Permissions: Flexible RBAC permission control

## Technical Architecture

- Based on YAO low-code development framework
- MySQL database
- OpenAI integration support
- Tencent Cloud Object Storage (COS)
- Docker containerized deployment

## Quick Start

### Requirements

- MySQL 5.7+
- YAO Framework
- Docker (optional)

### Installation

1. Clone the project

```bash
git clone https://github.com/sjzsdu/yao-fabric
cd yao-fabric
```

2. Configure environment variables

```bash
cp .env-template .env
```

Edit the .env file and configure the following required parameters:
- Database connection information
- OpenAI API key
- Tencent Cloud COS configuration

3. Initialize database

```bash
mysql -u root -p < database.sql
```

4. Start the service

```bash
yao start
```

### Docker Deployment

```bash
docker-compose up -d
```

## Usage Guide

1. Access the system
   - Admin panel: http://localhost:5099/admin/
   - Studio development tool: http://localhost:5077

2. Default admin account
   - Username: admin
   - Password: Please refer to the database initialization script

## Development Guide

### Directory Structure

```
├── apis/          # API interface definitions
├── charts/        # Chart configurations
├── flows/         # Business processes
├── forms/         # Form definitions
├── models/        # Data models
├── tables/        # Data tables
└── scripts/       # Business scripts
```

### Development Process

1. Define data models (models/)
2. Configure business APIs (apis/)
3. Develop page components (forms/, tables/)
4. Implement business logic (flows/, scripts/)

## License

[To be added]

## Contributing

Issues and Pull Requests are welcome.