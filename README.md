# Advanced Database Management with Oracle

A comprehensive hands-on laboratory for advanced database concepts using Oracle Database, SQL Developer, and Docker containerization.

---

## Overview

This repository provides a complete Docker-based Oracle Database environment for learning and practicing advanced database management concepts. It includes:

- 🐳 Dockerized Oracle Database XE
- 👥 HR Schema with realistic relational data model
- 🔧 SQL Developer integration
- 📚 Comprehensive examples and exercises

## Prerequisites

Before you begin, ensure you have the following installed:

- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- [Oracle SQL Developer](https://www.oracle.com/database/sqldeveloper/) (optional, for GUI access)
- Basic understanding of SQL and relational databases

## Getting Started

### Manual Schema Setup

Use this approach if you want to create your own custom schema from scratch.

#### Step 1: Access the Oracle Container

```bash
docker exec -it advanced_dbms bash
```

#### Step 2: Connect as System Administrator

```bash
sqlplus sys/oracle@XE as sysdba
```


---

### Automated HR Schema Installation

Use this approach to quickly set up the complete HR demonstration schema.

#### Step 1: Copy HR Schema Files

```bash
docker cp "<PATH_TO_HR_SCHEMA_FOLDER>" advanced_dbms:/home/hrschema
```

**Example (Windows):**
```bash
docker cp "D:\Github\Advanced-DBMS\HR Schema\human_resources" advanced_dbms:/home/hrschema
```

**Example (macOS/Linux):**
```bash
docker cp ~/projects/advanced-dbms/hr-schema advanced_dbms:/home/hrschema
```

#### Step 2: Run Installation Script

```bash
docker exec -it advanced_dbms sqlplus sys/oracle@XE as sysdba
```

Inside SQL*Plus, execute:

```sql
@/home/hrschema/hr_install.sql
```

#### Step 3: Verify Installation

```bash
docker exec -it advanced_dbms sqlplus hr/hr@XE
```

## SQL Developer Configuration

Connect to your Oracle Database using SQL Developer with the following settings:

| Parameter        | Value                          |
|-----------------|--------------------------------|
| **Connection Name** | `HR_XE` (or custom name)    |
| **Username**     | `hr`                          |
| **Password**     | `hr`                          |
| **Hostname**     | `localhost`                   |
| **Port**         | `1521`                        |
| **Service Name** | `XE`                          |
| **Role**         | `Default`                     |

💡 **Tip:** Enable "Save Password" for convenience, then click **Test** to verify the connection.

---

## Database Schema

The HR schema implements a realistic organizational structure with the following tables:

### Entity Relationship

```
REGIONS
  └─ COUNTRIES
       └─ LOCATIONS
            └─ DEPARTMENTS ←─┐
                 └─ EMPLOYEES │
                      ├─ JOBS  │
                      └────────┘
                      └─ JOB_HISTORY

---

## Troubleshooting

### Container Connection Issues

```bash
# Check if container is running
docker ps

# Start the container if stopped
docker start advanced_dbms

# View container logs
docker logs advanced_dbms
```


---
---

# Advanced Database Management with MongoDB

Minimal instructions to run MongoDB with Docker and connect from VS Code.

Prerequisites
- Docker installed
- VS Code (optional) with the MongoDB extension

Run MongoDB container
1. Pull and run mongodb image
<img width="799" height="801" alt="Screenshot 2025-11-26 185502" src="https://github.com/user-attachments/assets/d2d249e9-418a-4900-acec-5f29ea0e0a62" />


Connect from VS Code
1. Install the MongoDB extension.
2. Add a new connection → "Connect with connection string".
3. Use:
```
mongodb://localhost:27017
```

Notes
- The official image contains the defaults needed for a local development instance.
- Stop/remove container with:
```bash
docker stop mongodb_sandesh && docker rm mongodb_sandesh
```






