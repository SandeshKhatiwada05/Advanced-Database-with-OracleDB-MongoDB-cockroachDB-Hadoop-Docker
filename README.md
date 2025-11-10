# Advanced Database Management with Oracle

A comprehensive hands-on laboratory for advanced database concepts using Oracle Database, SQL Developer, and Docker containerization.

## 📋 Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
  - [Manual Schema Setup](#manual-schema-setup)
  - [Automated HR Schema Installation](#automated-hr-schema-installation)
- [SQL Developer Configuration](#sql-developer-configuration)
- [Database Schema](#database-schema)
- [Usage Examples](#usage-examples)
- [Troubleshooting](#troubleshooting)

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

#### Step 3: Configure Pluggable Database

```sql
ALTER SESSION SET CONTAINER = XEPDB1;
SHOW CON_NAME;
SHOW PDBS;
```

#### Step 4: Create Lab User

```sql
CREATE USER sandesh_csit IDENTIFIED BY sandesh_csit ACCOUNT UNLOCK;
GRANT CONNECT, RESOURCE, DBA TO sandesh_csit;
```

#### Step 5: Connect as Lab User

```bash
sqlplus sandesh_csit/sandesh_csit@XEPDB1
```

Verify your connection:

```sql
SHOW USER;
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

Test the schema:

```sql
SELECT employee_id, first_name, last_name, job_id 
FROM employees 
WHERE ROWNUM <= 10;
```

---

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
```

### Tables

| Table | Description |
|-------|-------------|
| **REGIONS** | Geographic regions (e.g., Americas, Europe, Asia) |
| **COUNTRIES** | Countries associated with regions |
| **LOCATIONS** | Physical office locations |
| **JOBS** | Job titles with salary ranges |
| **DEPARTMENTS** | Organizational departments |
| **EMPLOYEES** | Employee records with hierarchical relationships |
| **JOB_HISTORY** | Historical job assignments and transfers |

### Key Features

- ✅ **Sequences** for auto-incrementing primary keys
- ✅ **Foreign key constraints** for referential integrity
- ✅ **Indexes** on frequently queried columns
- ✅ **Check constraints** for data validation
- ✅ **Self-referential relationships** (manager hierarchy)

---

## Usage Examples

### Query Employee Information

```sql
-- Find employees in a specific department
SELECT e.first_name, e.last_name, d.department_name, j.job_title
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN jobs j ON e.job_id = j.job_id
WHERE d.department_name = 'IT';
```

### Hierarchical Queries

```sql
-- Display organizational hierarchy
SELECT LEVEL, employee_id, first_name, last_name, manager_id
FROM employees
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id
ORDER SIBLINGS BY last_name;
```

### Aggregate Analysis

```sql
-- Average salary by department
SELECT d.department_name, 
       COUNT(e.employee_id) as employee_count,
       ROUND(AVG(e.salary), 2) as avg_salary
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY avg_salary DESC;
```

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

### SQL*Plus Connection Errors

```bash
# Verify Oracle listener is running
docker exec -it advanced_dbms lsnrctl status

# Check database status
docker exec -it advanced_dbms sqlplus / as sysdba
SQL> SELECT status FROM v$instance;
```

### Permission Issues

If you encounter permission errors:

```sql
-- Grant additional privileges
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE TO <username>;
```

---

## Repository Structure

```
.
├── HR Schema/
│   └── human_resources/
│       ├── hr_install.sql
│       ├── hr_schema.sql
│       ├── hr_data.sql
│       └── hr_indexes.sql
├── examples/
│   ├── queries/
│   └── exercises/
├── docker-compose.yml
└── README.md
```

---

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## License

This project is intended for educational purposes.

---

**Happy Learning! 🚀**
