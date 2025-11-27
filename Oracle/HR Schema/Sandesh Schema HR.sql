-- =====================================================
-- Oracle SQL Developer DDL Script
-- HR Database Schema
-- =====================================================

-- Drop tables if they exist (in reverse order due to foreign keys)
DROP TABLE job_history CASCADE CONSTRAINTS;
DROP TABLE employees CASCADE CONSTRAINTS;
DROP TABLE departments CASCADE CONSTRAINTS;
DROP TABLE jobs CASCADE CONSTRAINTS;
DROP TABLE locations CASCADE CONSTRAINTS;
DROP TABLE countries CASCADE CONSTRAINTS;
DROP TABLE regions CASCADE CONSTRAINTS;

-- Drop sequences if they exist
DROP SEQUENCE regions_seq;
DROP SEQUENCE countries_seq;
DROP SEQUENCE locations_seq;
DROP SEQUENCE departments_seq;
DROP SEQUENCE employees_seq;

-- =====================================================
-- Create REGIONS table
-- =====================================================
CREATE TABLE regions (
    region_id NUMBER PRIMARY KEY,
    region_name VARCHAR2(50) NOT NULL
);

-- =====================================================
-- Create COUNTRIES table
-- =====================================================
CREATE TABLE countries (
    country_id CHAR(2) PRIMARY KEY,
    country_name VARCHAR2(100) NOT NULL,
    region_id NUMBER NOT NULL,
    CONSTRAINT fk_countries_regions 
        FOREIGN KEY (region_id) 
        REFERENCES regions(region_id)
);

-- =====================================================
-- Create LOCATIONS table
-- =====================================================
CREATE TABLE locations (
    location_id NUMBER PRIMARY KEY,
    street_address VARCHAR2(200),
    postal_code VARCHAR2(20),
    city VARCHAR2(100) NOT NULL,
    state_province VARCHAR2(100),
    country_id CHAR(2) NOT NULL,
    CONSTRAINT fk_locations_countries 
        FOREIGN KEY (country_id) 
        REFERENCES countries(country_id)
);

-- =====================================================
-- Create JOBS table
-- =====================================================
CREATE TABLE jobs (
    job_id VARCHAR2(20) PRIMARY KEY,
    job_title VARCHAR2(100) NOT NULL,
    min_salary NUMBER,
    max_salary NUMBER,
    CONSTRAINT chk_salary_range 
        CHECK (max_salary >= min_salary)
);

-- =====================================================
-- Create DEPARTMENTS table
-- =====================================================
CREATE TABLE departments (
    department_id NUMBER PRIMARY KEY,
    department_name VARCHAR2(100) NOT NULL,
    location_id NUMBER,
    manager_id NUMBER,
    CONSTRAINT fk_departments_locations 
        FOREIGN KEY (location_id) 
        REFERENCES locations(location_id)
);

-- =====================================================
-- Create EMPLOYEES table
-- =====================================================
CREATE TABLE employees (
    employee_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) NOT NULL UNIQUE,
    phone_number VARCHAR2(30),
    hire_date DATE NOT NULL,
    job_id VARCHAR2(20) NOT NULL,
    salary NUMBER,
    commission_pct NUMBER,
    manager_id NUMBER,
    department_id NUMBER,
    CONSTRAINT fk_employees_jobs 
        FOREIGN KEY (job_id) 
        REFERENCES jobs(job_id),
    CONSTRAINT fk_employees_manager 
        FOREIGN KEY (manager_id) 
        REFERENCES employees(employee_id),
    CONSTRAINT fk_employees_departments 
        FOREIGN KEY (department_id) 
        REFERENCES departments(department_id),
    CONSTRAINT chk_commission_pct 
        CHECK (commission_pct >= 0 AND commission_pct <= 1)
);

-- Add foreign key for departments.manager_id
ALTER TABLE departments
ADD CONSTRAINT fk_departments_manager 
    FOREIGN KEY (manager_id) 
    REFERENCES employees(employee_id);

-- =====================================================
-- Create JOB_HISTORY table
-- =====================================================
CREATE TABLE job_history (
    employee_id NUMBER NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    job_id VARCHAR2(20) NOT NULL,
    department_id NUMBER,
    CONSTRAINT pk_job_history 
        PRIMARY KEY (employee_id, start_date),
    CONSTRAINT fk_job_history_employee 
        FOREIGN KEY (employee_id) 
        REFERENCES employees(employee_id),
    CONSTRAINT fk_job_history_job 
        FOREIGN KEY (job_id) 
        REFERENCES jobs(job_id),
    CONSTRAINT fk_job_history_department 
        FOREIGN KEY (department_id) 
        REFERENCES departments(department_id),
    CONSTRAINT chk_job_history_dates 
        CHECK (end_date > start_date)
);

-- =====================================================
-- Create Sequences for auto-increment
-- =====================================================
CREATE SEQUENCE regions_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE SEQUENCE locations_seq
    START WITH 1000
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE SEQUENCE departments_seq
    START WITH 10
    INCREMENT BY 10
    NOCACHE
    NOCYCLE;

CREATE SEQUENCE employees_seq
    START WITH 100
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- =====================================================
-- Create Indexes for performance
-- =====================================================
CREATE INDEX idx_employees_manager ON employees(manager_id);
CREATE INDEX idx_employees_department ON employees(department_id);
CREATE INDEX idx_employees_job ON employees(job_id);
CREATE INDEX idx_departments_location ON departments(location_id);
CREATE INDEX idx_departments_manager ON departments(manager_id);
CREATE INDEX idx_locations_country ON locations(country_id);
CREATE INDEX idx_countries_region ON countries(region_id);
CREATE INDEX idx_job_history_employee ON job_history(employee_id);
CREATE INDEX idx_job_history_job ON job_history(job_id);
CREATE INDEX idx_job_history_department ON job_history(department_id);

-- =====================================================
-- Comments for documentation
-- =====================================================
COMMENT ON TABLE regions IS 'Geographic regions';
COMMENT ON TABLE countries IS 'Country information';
COMMENT ON TABLE locations IS 'Physical location addresses';
COMMENT ON TABLE jobs IS 'Job classifications and salary ranges';
COMMENT ON TABLE departments IS 'Company departments';
COMMENT ON TABLE employees IS 'Employee information';
COMMENT ON TABLE job_history IS 'Employee job history';

-- =====================================================
-- Script completed
-- =====================================================
PROMPT Schema created successfully!




-- =====================================================
-- Oracle HR Database - Complete Sample Data Insertion
-- 40-50 records per table
-- =====================================================

-- =====================================================
-- Insert REGIONS (50 records)
-- =====================================================
INSERT ALL
    INTO regions (region_id, region_name) VALUES (1, 'North America')
    INTO regions (region_id, region_name) VALUES (2, 'South America')
    INTO regions (region_id, region_name) VALUES (3, 'Europe')
    INTO regions (region_id, region_name) VALUES (4, 'Asia')
    INTO regions (region_id, region_name) VALUES (5, 'Africa')
    INTO regions (region_id, region_name) VALUES (6, 'Middle East')
    INTO regions (region_id, region_name) VALUES (7, 'Oceania')
    INTO regions (region_id, region_name) VALUES (8, 'Caribbean')
    INTO regions (region_id, region_name) VALUES (9, 'Central America')
    INTO regions (region_id, region_name) VALUES (10, 'Northern Europe')
    INTO regions (region_id, region_name) VALUES (11, 'Southern Europe')
    INTO regions (region_id, region_name) VALUES (12, 'Western Europe')
    INTO regions (region_id, region_name) VALUES (13, 'Eastern Europe')
    INTO regions (region_id, region_name) VALUES (14, 'Southeast Asia')
    INTO regions (region_id, region_name) VALUES (15, 'East Asia')
    INTO regions (region_id, region_name) VALUES (16, 'South Asia')
    INTO regions (region_id, region_name) VALUES (17, 'Central Asia')
    INTO regions (region_id, region_name) VALUES (18, 'North Africa')
    INTO regions (region_id, region_name) VALUES (19, 'Sub-Saharan Africa')
    INTO regions (region_id, region_name) VALUES (20, 'West Africa')
    INTO regions (region_id, region_name) VALUES (21, 'East Africa')
    INTO regions (region_id, region_name) VALUES (22, 'Southern Africa')
    INTO regions (region_id, region_name) VALUES (23, 'Central Africa')
    INTO regions (region_id, region_name) VALUES (24, 'Polynesia')
    INTO regions (region_id, region_name) VALUES (25, 'Melanesia')
    INTO regions (region_id, region_name) VALUES (26, 'Micronesia')
    INTO regions (region_id, region_name) VALUES (27, 'Australia and New Zealand')
    INTO regions (region_id, region_name) VALUES (28, 'British Isles')
    INTO regions (region_id, region_name) VALUES (29, 'Scandinavia')
    INTO regions (region_id, region_name) VALUES (30, 'Iberian Peninsula')
    INTO regions (region_id, region_name) VALUES (31, 'Balkans')
    INTO regions (region_id, region_name) VALUES (32, 'Baltic States')
    INTO regions (region_id, region_name) VALUES (33, 'Caucasus')
    INTO regions (region_id, region_name) VALUES (34, 'Arabian Peninsula')
    INTO regions (region_id, region_name) VALUES (35, 'Levant')
    INTO regions (region_id, region_name) VALUES (36, 'Maghreb')
    INTO regions (region_id, region_name) VALUES (37, 'Horn of Africa')
    INTO regions (region_id, region_name) VALUES (38, 'Great Lakes Africa')
    INTO regions (region_id, region_name) VALUES (39, 'Sahel')
    INTO regions (region_id, region_name) VALUES (40, 'Gulf States')
    INTO regions (region_id, region_name) VALUES (41, 'Andean Region')
    INTO regions (region_id, region_name) VALUES (42, 'Southern Cone')
    INTO regions (region_id, region_name) VALUES (43, 'Guianas')
    INTO regions (region_id, region_name) VALUES (44, 'Greater Antilles')
    INTO regions (region_id, region_name) VALUES (45, 'Lesser Antilles')
    INTO regions (region_id, region_name) VALUES (46, 'Indochina')
    INTO regions (region_id, region_name) VALUES (47, 'Malay Archipelago')
    INTO regions (region_id, region_name) VALUES (48, 'Indian Subcontinent')
    INTO regions (region_id, region_name) VALUES (49, 'Himalayan Region')
    INTO regions (region_id, region_name) VALUES (50, 'Pacific Islands')
SELECT * FROM dual;

COMMIT;

-- =====================================================
-- Insert COUNTRIES (50 records)
-- =====================================================
INSERT ALL
    INTO countries (country_id, country_name, region_id) VALUES ('US', 'United States of America', 1)
    INTO countries (country_id, country_name, region_id) VALUES ('CA', 'Canada', 1)
    INTO countries (country_id, country_name, region_id) VALUES ('MX', 'Mexico', 1)
    INTO countries (country_id, country_name, region_id) VALUES ('BR', 'Brazil', 2)
    INTO countries (country_id, country_name, region_id) VALUES ('AR', 'Argentina', 2)
    INTO countries (country_id, country_name, region_id) VALUES ('CL', 'Chile', 2)
    INTO countries (country_id, country_name, region_id) VALUES ('CO', 'Colombia', 2)
    INTO countries (country_id, country_name, region_id) VALUES ('PE', 'Peru', 2)
    INTO countries (country_id, country_name, region_id) VALUES ('GB', 'United Kingdom', 3)
    INTO countries (country_id, country_name, region_id) VALUES ('DE', 'Germany', 3)
    INTO countries (country_id, country_name, region_id) VALUES ('FR', 'France', 3)
    INTO countries (country_id, country_name, region_id) VALUES ('IT', 'Italy', 3)
    INTO countries (country_id, country_name, region_id) VALUES ('ES', 'Spain', 3)
    INTO countries (country_id, country_name, region_id) VALUES ('NL', 'Netherlands', 3)
    INTO countries (country_id, country_name, region_id) VALUES ('BE', 'Belgium', 3)
    INTO countries (country_id, country_name, region_id) VALUES ('CH', 'Switzerland', 3)
    INTO countries (country_id, country_name, region_id) VALUES ('SE', 'Sweden', 3)
    INTO countries (country_id, country_name, region_id) VALUES ('NO', 'Norway', 3)
    INTO countries (country_id, country_name, region_id) VALUES ('DK', 'Denmark', 3)
    INTO countries (country_id, country_name, region_id) VALUES ('FI', 'Finland', 3)
    INTO countries (country_id, country_name, region_id) VALUES ('PL', 'Poland', 3)
    INTO countries (country_id, country_name, region_id) VALUES ('CN', 'China', 4)
    INTO countries (country_id, country_name, region_id) VALUES ('JP', 'Japan', 4)
    INTO countries (country_id, country_name, region_id) VALUES ('IN', 'India', 4)
    INTO countries (country_id, country_name, region_id) VALUES ('KR', 'South Korea', 4)
    INTO countries (country_id, country_name, region_id) VALUES ('SG', 'Singapore', 4)
    INTO countries (country_id, country_name, region_id) VALUES ('TH', 'Thailand', 4)
    INTO countries (country_id, country_name, region_id) VALUES ('VN', 'Vietnam', 4)
    INTO countries (country_id, country_name, region_id) VALUES ('MY', 'Malaysia', 4)
    INTO countries (country_id, country_name, region_id) VALUES ('ID', 'Indonesia', 4)
    INTO countries (country_id, country_name, region_id) VALUES ('PH', 'Philippines', 4)
    INTO countries (country_id, country_name, region_id) VALUES ('AU', 'Australia', 7)
    INTO countries (country_id, country_name, region_id) VALUES ('NZ', 'New Zealand', 7)
    INTO countries (country_id, country_name, region_id) VALUES ('ZA', 'South Africa', 5)
    INTO countries (country_id, country_name, region_id) VALUES ('EG', 'Egypt', 5)
    INTO countries (country_id, country_name, region_id) VALUES ('NG', 'Nigeria', 5)
    INTO countries (country_id, country_name, region_id) VALUES ('KE', 'Kenya', 5)
    INTO countries (country_id, country_name, region_id) VALUES ('AE', 'United Arab Emirates', 6)
    INTO countries (country_id, country_name, region_id) VALUES ('SA', 'Saudi Arabia', 6)
    INTO countries (country_id, country_name, region_id) VALUES ('IL', 'Israel', 6)
    INTO countries (country_id, country_name, region_id) VALUES ('TR', 'Turkey', 6)
    INTO countries (country_id, country_name, region_id) VALUES ('RU', 'Russia', 3)
    INTO countries (country_id, country_name, region_id) VALUES ('UA', 'Ukraine', 3)
    INTO countries (country_id, country_name, region_id) VALUES ('AT', 'Austria', 3)
    INTO countries (country_id, country_name, region_id) VALUES ('PT', 'Portugal', 3)
    INTO countries (country_id, country_name, region_id) VALUES ('GR', 'Greece', 3)
    INTO countries (country_id, country_name, region_id) VALUES ('IE', 'Ireland', 3)
    INTO countries (country_id, country_name, region_id) VALUES ('CZ', 'Czech Republic', 3)
    INTO countries (country_id, country_name, region_id) VALUES ('HU', 'Hungary', 3)
    INTO countries (country_id, country_name, region_id) VALUES ('RO', 'Romania', 3)
SELECT * FROM dual;

COMMIT;

-- =====================================================
-- Insert LOCATIONS (50 records)
-- =====================================================
INSERT ALL
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (1000, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (1100, '2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (1200, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (1300, '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (1400, '8204 Arthur St', NULL, 'London', NULL, 'GB')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (1500, 'Magdalen Centre, The Oxford Science Park', 'OX9 9ZB', 'Oxford', 'Oxford', 'GB')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (1600, '9702 Chester Road', '09629850293', 'Stretford', 'Manchester', 'GB')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (1700, 'Schwanthalerstr. 7031', '80925', 'Munich', 'Bavaria', 'DE')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (1800, 'Rua Frei Caneca 1360', '01307-002', 'Sao Paulo', 'Sao Paulo', 'BR')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (1900, '20 Rue des Corps-Saints', '1730', 'Geneva', 'Geneve', 'CH')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (2000, 'Corso Italia 555', '10135', 'Rome', NULL, 'IT')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (2100, 'Murtenstrasse 921', '3095', 'Bern', 'BE', 'CH')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (2200, '12-98 Victoria Street', '2901', 'Sydney', 'New South Wales', 'AU')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (2300, '198 Clementi North', '540198', 'Singapore', NULL, 'SG')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (2400, '8204 Arthur St', NULL, 'London', NULL, 'GB')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (2500, 'Taj Palace Hotel', '110021', 'New Delhi', NULL, 'IN')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (2600, '9-13 Bendemeer Road', '339944', 'Singapore', NULL, 'SG')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (2700, '4092 Furth Circle', '361042', 'Munich', 'Bavaria', 'DE')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (2800, 'Hauptstr. 12', '60528', 'Frankfurt', 'Hesse', 'DE')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (2900, '1297 Via Cola di Rie', '00989', 'Rome', NULL, 'IT')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (3000, '93091 Calle della Testa', '10934', 'Venice', NULL, 'IT')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (3100, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 'JP')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (3200, '40-5-12 Laogianggen', '190518', 'Beijing', NULL, 'CN')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (3300, '1450 Point Drive', '68110', 'Omaha', 'Nebraska', 'US')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (3400, '101 Main Street', '02139', 'Cambridge', 'Massachusetts', 'US')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (3500, '200 Technology Park', '94043', 'Mountain View', 'California', 'US')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (3600, '350 Fifth Avenue', '10118', 'New York', 'New York', 'US')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (3700, '450 Park Avenue', '10022', 'New York', 'New York', 'US')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (3800, '789 Michigan Avenue', '60611', 'Chicago', 'Illinois', 'US')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (3900, '456 Peachtree Road', '30326', 'Atlanta', 'Georgia', 'US')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (4000, '890 Collins Street', '3000', 'Melbourne', 'Victoria', 'AU')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (4100, '67 Queen Street', '1010', 'Auckland', NULL, 'NZ')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (4200, '123 Marina Boulevard', '018989', 'Singapore', NULL, 'SG')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (4300, '789 Orchard Road', '238839', 'Singapore', NULL, 'SG')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (4400, '456 Nathan Road', '999077', 'Hong Kong', 'Kowloon', 'CN')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (4500, '321 Gangnam-daero', '06236', 'Seoul', NULL, 'KR')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (4600, '789 Sukhumvit Road', '10110', 'Bangkok', NULL, 'TH')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (4700, '456 Jalan Sultan Ismail', '50250', 'Kuala Lumpur', NULL, 'MY')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (4800, '321 Ayala Avenue', '1226', 'Makati', 'Metro Manila', 'PH')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (4900, '123 Jalan Thamrin', '10340', 'Jakarta', NULL, 'ID')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (5000, '456 Le Loi Boulevard', '700000', 'Ho Chi Minh City', NULL, 'VN')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (5100, '789 Sheikh Zayed Road', '00000', 'Dubai', NULL, 'AE')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (5200, '321 King Fahd Road', '11564', 'Riyadh', NULL, 'SA')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (5300, '123 Rothschild Boulevard', '66881', 'Tel Aviv', NULL, 'IL')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (5400, '456 Long Street', '8001', 'Cape Town', 'Western Cape', 'ZA')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (5500, '789 Tahrir Street', '11511', 'Cairo', NULL, 'EG')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (5600, '321 Victoria Island', '101241', 'Lagos', NULL, 'NG')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (5700, '123 Kimathi Street', '00100', 'Nairobi', NULL, 'KE')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (5800, '456 Istiklal Avenue', '34433', 'Istanbul', NULL, 'TR')
    INTO locations (location_id, street_address, postal_code, city, state_province, country_id) 
        VALUES (5900, '789 Nevsky Prospect', '191186', 'St Petersburg', NULL, 'RU')
SELECT * FROM dual;

COMMIT;

-- =====================================================
-- Insert JOBS (50 records)
-- =====================================================
INSERT ALL
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('AD_PRES', 'President', 20000, 40000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('AD_VP', 'Vice President', 15000, 30000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('AD_ASST', 'Administrative Assistant', 3000, 6000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('FI_MGR', 'Finance Manager', 8200, 16000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('FI_ACCOUNT', 'Accountant', 4200, 9000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('AC_MGR', 'Accounting Manager', 8200, 16000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('AC_ACCOUNT', 'Public Accountant', 4200, 9000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('SA_MAN', 'Sales Manager', 10000, 20000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('SA_REP', 'Sales Representative', 6000, 12000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('PU_MAN', 'Purchasing Manager', 8000, 15000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('PU_CLERK', 'Purchasing Clerk', 2500, 5500)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('ST_MAN', 'Stock Manager', 5500, 8500)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('ST_CLERK', 'Stock Clerk', 2000, 5000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('SH_CLERK', 'Shipping Clerk', 2500, 5500)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('IT_PROG', 'Programmer', 4000, 10000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('MK_MAN', 'Marketing Manager', 9000, 15000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('MK_REP', 'Marketing Representative', 4000, 9000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('HR_REP', 'Human Resources Representative', 4000, 9000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('PR_REP', 'Public Relations Representative', 4500, 10500)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('IT_MGR', 'IT Manager', 10000, 18000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('IT_SUPPORT', 'IT Support Specialist', 3500, 7500)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('IT_DBA', 'Database Administrator', 6000, 12000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('IT_SEC', 'Security Analyst', 7000, 14000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('IT_NET', 'Network Engineer', 6500, 13000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('IT_DEV', 'Software Developer', 5000, 12000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('IT_ARCH', 'Systems Architect', 9000, 17000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('CS_REP', 'Customer Service Representative', 3000, 6500)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('CS_MGR', 'Customer Service Manager', 7000, 13000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('OPS_MGR', 'Operations Manager', 8500, 16000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('OPS_COORD', 'Operations Coordinator', 4500, 8500)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('QA_MGR', 'Quality Assurance Manager', 8000, 15000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('QA_ANALYST', 'QA Analyst', 4500, 9500)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('PROJ_MGR', 'Project Manager', 9000, 17000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('PROD_MGR', 'Product Manager', 9500, 18000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('BUS_ANALYST', 'Business Analyst', 5500, 11000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('DATA_ANALYST', 'Data Analyst', 5000, 10500)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('DATA_SCI', 'Data Scientist', 8000, 16000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('UX_DES', 'UX Designer', 6000, 12500)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('UI_DES', 'UI Designer', 5500, 11500)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('GRAPH_DES', 'Graphic Designer', 4000, 9000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('CONTENT_WR', 'Content Writer', 3500, 7500)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('TECH_WR', 'Technical Writer', 4500, 9500)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('TRAIN_SPEC', 'Training Specialist', 4000, 8500)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('REC_SPEC', 'Recruitment Specialist', 4500, 9000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('COMP_BEN', 'Compensation and Benefits Specialist', 5000, 10000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('LEG_COUN', 'Legal Counsel', 10000, 20000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('LEG_ASST', 'Legal Assistant', 3500, 7000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('EXEC_ASST', 'Executive Assistant', 4500, 9500)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('OFF_MGR', 'Office Manager', 5000, 10000)
    INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('FAC_MGR', 'Facilities Manager', 6000, 12000)
SELECT * FROM dual;

COMMIT;

-- =====================================================
-- Insert DEPARTMENTS (50 records)
-- =====================================================
INSERT ALL
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (10, 'Administration', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (20, 'Marketing', 1800, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (30, 'Purchasing', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (40, 'Human Resources', 2400, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (50, 'Shipping', 1500, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (60, 'IT', 1400, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (70, 'Public Relations', 2700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (80, 'Sales', 2500, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (90, 'Executive', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (100, 'Finance', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (110, 'Accounting', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (120, 'Treasury', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (130, 'Corporate Tax', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (140, 'Control And Credit', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (150, 'Shareholder Services', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (160, 'Benefits', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (170, 'Manufacturing', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (180, 'Construction', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (190, 'Contracting', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (200, 'Operations', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (210, 'IT Support', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (220, 'NOC', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (230, 'IT Helpdesk', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (240, 'Government Sales', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (250, 'Retail Sales', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (260, 'Recruiting', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (270, 'Payroll', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (280, 'Customer Service', 2500, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (290, 'Research and Development', 3100, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (300, 'Quality Assurance', 1400, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (310, 'Product Management', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (320, 'Business Intelligence', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (330, 'Data Analytics', 3500, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (340, 'Database Administration', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (350, 'Network Operations', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (360, 'Security', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (370, 'Training', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (380, 'Documentation', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (390, 'Legal', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (400, 'Compliance', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (410, 'Facilities', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (420, 'Real Estate', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (430, 'Strategic Planning', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (440, 'Corporate Communications', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (450, 'Investor Relations', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (460, 'Supply Chain', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (470, 'Logistics', 1500, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (480, 'Procurement', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (490, 'Vendor Management', 1700, NULL)
    INTO departments (department_id, department_name, location_id, manager_id) VALUES (500, 'Risk Management', 1700, NULL)
SELECT * FROM dual;

COMMIT;

-- =====================================================
-- Step : Insert EMPLOYEES (Top executives first - no manager)
-- =====================================================
INSERT ALL
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (100, 'Steven', 'King', 'SKING', '515.123.4567', DATE '2003-06-17', 'AD_PRES', 24000, NULL, NULL, 90)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', DATE '2005-09-21', 'AD_VP', 17000, NULL, 100, 90)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (102, 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', DATE '2001-01-13', 'AD_VP', 17000, NULL, 100, 90)
SELECT * FROM dual;

COMMIT;

-- =====================================================
-- Step : Insert remaining EMPLOYEES (with managers)
-- =====================================================
INSERT ALL
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (103, 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', DATE '2006-01-03', 'IT_PROG', 9000, NULL, 102, 60)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (104, 'Bruce', 'Ernst', 'BERNST', '590.423.4568', DATE '2007-05-21', 'IT_PROG', 6000, NULL, 103, 60)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (105, 'David', 'Austin', 'DAUSTIN', '590.423.4569', DATE '2005-06-25', 'IT_PROG', 4800, NULL, 103, 60)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (106, 'Valli', 'Pataballa', 'VPATABAL', '590.423.4560', DATE '2006-02-05', 'IT_PROG', 4800, NULL, 103, 60)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (107, 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567', DATE '2007-02-07', 'IT_PROG', 4200, NULL, 103, 60)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (108, 'Nancy', 'Greenberg', 'NGREENBE', '515.124.4569', DATE '2002-08-17', 'FI_MGR', 12008, NULL, 101, 100)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (109, 'Daniel', 'Faviet', 'DFAVIET', '515.124.4169', DATE '2002-08-16', 'FI_ACCOUNT', 9000, NULL, 108, 100)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (110, 'John', 'Chen', 'JCHEN', '515.124.4269', DATE '2005-09-28', 'FI_ACCOUNT', 8200, NULL, 108, 100)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (111, 'Ismael', 'Sciarra', 'ISCIARRA', '515.124.4369', DATE '2005-09-30', 'FI_ACCOUNT', 7700, NULL, 108, 100)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (112, 'Jose Manuel', 'Urman', 'JMURMAN', '515.124.4469', DATE '2006-03-07', 'FI_ACCOUNT', 7800, NULL, 108, 100)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (113, 'Luis', 'Popp', 'LPOPP', '515.124.4567', DATE '2007-12-07', 'FI_ACCOUNT', 6900, NULL, 108, 100)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (114, 'Den', 'Raphaely', 'DRAPHEAL', '515.127.4561', DATE '2002-12-07', 'PU_MAN', 11000, NULL, 100, 30)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (115, 'Alexander', 'Khoo', 'AKHOO', '515.127.4562', DATE '2003-05-18', 'PU_CLERK', 3100, NULL, 114, 30)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (116, 'Shelli', 'Baida', 'SBAIDA', '515.127.4563', DATE '2005-12-24', 'PU_CLERK', 2900, NULL, 114, 30)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (117, 'Sigal', 'Tobias', 'STOBIAS', '515.127.4564', DATE '2005-07-24', 'PU_CLERK', 2800, NULL, 114, 30)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (118, 'Guy', 'Himuro', 'GHIMURO', '515.127.4565', DATE '2006-11-15', 'PU_CLERK', 2600, NULL, 114, 30)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (119, 'Karen', 'Colmenares', 'KCOLMENA', '515.127.4566', DATE '2007-08-10', 'PU_CLERK', 2500, NULL, 114, 30)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (120, 'Matthew', 'Weiss', 'MWEISS', '650.123.1234', DATE '2004-07-18', 'ST_MAN', 8000, NULL, 100, 50)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (121, 'Adam', 'Fripp', 'AFRIPP', '650.123.2234', DATE '2005-04-10', 'ST_MAN', 8200, NULL, 100, 50)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (122, 'Payam', 'Kaufling', 'PKAUFLIN', '650.123.3234', DATE '2003-05-01', 'ST_MAN', 7900, NULL, 100, 50)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (123, 'Shanta', 'Vollman', 'SVOLLMAN', '650.123.4234', DATE '2005-10-10', 'ST_MAN', 6500, NULL, 100, 50)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (124, 'Kevin', 'Mourgos', 'KMOURGOS', '650.123.5234', DATE '2007-11-16', 'ST_MAN', 5800, NULL, 100, 50)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (125, 'Julia', 'Nayer', 'JNAYER', '650.124.1214', DATE '2005-07-16', 'ST_CLERK', 3200, NULL, 120, 50)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (126, 'Irene', 'Mikkilineni', 'IMIKKILI', '650.124.1224', DATE '2006-09-28', 'ST_CLERK', 2700, NULL, 120, 50)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (127, 'James', 'Landry', 'JLANDRY', '650.124.1334', DATE '2007-01-14', 'ST_CLERK', 2400, NULL, 120, 50)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (128, 'Steven', 'Markle', 'SMARKLE', '650.124.1434', DATE '2008-03-08', 'ST_CLERK', 2200, NULL, 120, 50)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (129, 'Laura', 'Bissot', 'LBISSOT', '650.124.5234', DATE '2005-08-20', 'ST_CLERK', 3300, NULL, 121, 50)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (130, 'Mozhe', 'Atkinson', 'MATKINSO', '650.124.6234', DATE '2005-10-30', 'ST_CLERK', 2800, NULL, 121, 50)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (131, 'James', 'Marlow', 'JAMRLOW', '650.124.7234', DATE '2005-02-16', 'ST_CLERK', 2500, NULL, 121, 50)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (132, 'TJ', 'Olson', 'TJOLSON', '650.124.8234', DATE '2007-04-10', 'ST_CLERK', 2100, NULL, 121, 50)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (133, 'Jason', 'Mallin', 'JMALLIN', '650.127.1934', DATE '2004-06-14', 'ST_CLERK', 3300, NULL, 122, 50)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (134, 'Michael', 'Rogers', 'MROGERS', '650.127.1834', DATE '2006-08-26', 'ST_CLERK', 2900, NULL, 122, 50)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (135, 'Ki', 'Gee', 'KGEE', '650.127.1734', DATE '2007-12-12', 'ST_CLERK', 2400, NULL, 122, 50)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (136, 'Hazel', 'Philtanker', 'HPHILTAN', '650.127.1634', DATE '2008-02-06', 'ST_CLERK', 2200, NULL, 122, 50)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (137, 'Renske', 'Ladwig', 'RLADWIG', '650.121.1234', DATE '2003-07-14', 'ST_CLERK', 3600, NULL, 123, 50)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (138, 'Stephen', 'Stiles', 'SSTILES', '650.121.2034', DATE '2005-10-26', 'ST_CLERK', 3200, NULL, 123, 50)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (139, 'John', 'Seo', 'JSEO', '650.121.2019', DATE '2006-02-12', 'ST_CLERK', 2700, NULL, 123, 50)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (140, 'Joshua', 'Patel', 'JPATEL', '650.121.1834', DATE '2006-04-06', 'ST_CLERK', 2500, NULL, 123, 50)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (141, 'Trenna', 'Rajs', 'TRAJS', '650.121.8009', DATE '2003-10-17', 'ST_CLERK', 3500, NULL, 124, 50)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (142, 'Curtis', 'Davies', 'CDAVIES', '650.121.2994', DATE '2005-01-29', 'ST_CLERK', 3100, NULL, 124, 50)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (143, 'Randall', 'Matos', 'RMATOS', '650.121.2874', DATE '2006-03-15', 'ST_CLERK', 2600, NULL, 124, 50)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (144, 'Peter', 'Vargas', 'PVARGAS', '650.121.2004', DATE '2006-07-09', 'ST_CLERK', 2500, NULL, 124, 50)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (145, 'John', 'Russell', 'JRUSSEL', '011.44.1344.429268', DATE '2004-10-01', 'SA_MAN', 14000, 0.4, 100, 80)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (146, 'Karen', 'Partners', 'KPARTNER', '011.44.1344.467268', DATE '2005-01-05', 'SA_MAN', 13500, 0.3, 100, 80)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (147, 'Alberto', 'Errazuriz', 'AERRAZUR', '011.44.1344.429278', DATE '2005-03-10', 'SA_MAN', 12000, 0.3, 100, 80)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (148, 'Gerald', 'Cambrault', 'GCAMBRAU', '011.44.1344.619268', DATE '2007-10-15', 'SA_MAN', 11000, 0.3, 100, 80)
    INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (149, 'Eleni', 'Zlotkey', 'EZLOTKEY', '011.44.1344.429018', DATE '2008-01-29', 'SA_MAN', 10500, 0.2, 100, 80)
SELECT * FROM dual;

COMMIT;

-- Update department managers now that employees exist
UPDATE departments SET manager_id = 100 WHERE department_id = 90;
UPDATE departments SET manager_id = 101 WHERE department_id = 100;
UPDATE departments SET manager_id = 102 WHERE department_id = 60;
UPDATE departments SET manager_id = 114 WHERE department_id = 30;
UPDATE departments SET manager_id = 120 WHERE department_id = 50;
UPDATE departments SET manager_id = 145 WHERE department_id = 80;
UPDATE departments SET manager_id = 108 WHERE department_id = 110;

COMMIT;

-- =====================================================
-- Insert JOB_HISTORY (50 records) - COMPLETE
-- =====================================================
INSERT ALL
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (102, DATE '2001-01-13', DATE '2006-07-24', 'IT_PROG', 60)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (101, DATE '1997-09-21', DATE '2001-10-27', 'AC_ACCOUNT', 110)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (101, DATE '2001-10-28', DATE '2005-03-15', 'AC_MGR', 110)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (103, DATE '2001-01-03', DATE '2006-01-02', 'IT_PROG', 60)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (104, DATE '2002-05-21', DATE '2007-05-20', 'IT_PROG', 60)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (105, DATE '2000-06-25', DATE '2005-06-24', 'IT_PROG', 60)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (106, DATE '2001-02-05', DATE '2006-02-04', 'IT_PROG', 60)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (107, DATE '2002-02-07', DATE '2007-02-06', 'IT_PROG', 60)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (108, DATE '1998-08-17', DATE '2002-08-16', 'FI_ACCOUNT', 100)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (109, DATE '1998-08-16', DATE '2002-08-15', 'FI_ACCOUNT', 100)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (110, DATE '2001-09-28', DATE '2005-09-27', 'FI_ACCOUNT', 100)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (111, DATE '2001-09-30', DATE '2005-09-29', 'FI_ACCOUNT', 100)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (112, DATE '2002-03-07', DATE '2006-03-06', 'FI_ACCOUNT', 100)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (113, DATE '2003-12-07', DATE '2007-12-06', 'FI_ACCOUNT', 100)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (114, DATE '1998-12-07', DATE '2002-12-06', 'PU_CLERK', 30)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (115, DATE '1999-05-18', DATE '2003-05-17', 'PU_CLERK', 30)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (116, DATE '2001-12-24', DATE '2005-12-23', 'PU_CLERK', 30)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (117, DATE '2001-07-24', DATE '2005-07-23', 'PU_CLERK', 30)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (118, DATE '2002-11-15', DATE '2006-11-14', 'PU_CLERK', 30)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (119, DATE '2003-08-10', DATE '2007-08-09', 'PU_CLERK', 30)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (120, DATE '2000-07-18', DATE '2004-07-17', 'ST_CLERK', 50)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (121, DATE '2001-04-10', DATE '2005-04-09', 'ST_CLERK', 50)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (122, DATE '1999-05-01', DATE '2003-04-30', 'ST_CLERK', 50)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (123, DATE '2001-10-10', DATE '2005-10-09', 'ST_CLERK', 50)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (124, DATE '2003-11-16', DATE '2007-11-15', 'ST_CLERK', 50)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (125, DATE '2001-07-16', DATE '2005-07-15', 'ST_CLERK', 50)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (126, DATE '2002-09-28', DATE '2006-09-27', 'ST_CLERK', 50)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (127, DATE '2003-01-14', DATE '2007-01-13', 'ST_CLERK', 50)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (128, DATE '2004-03-08', DATE '2008-03-07', 'ST_CLERK', 50)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (129, DATE '2001-08-20', DATE '2005-08-19', 'ST_CLERK', 50)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (130, DATE '2001-10-30', DATE '2005-10-29', 'ST_CLERK', 50)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (131, DATE '2001-02-16', DATE '2005-02-15', 'ST_CLERK', 50)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (132, DATE '2003-04-10', DATE '2007-04-09', 'ST_CLERK', 50)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (133, DATE '2000-06-14', DATE '2004-06-13', 'ST_CLERK', 50)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (134, DATE '2002-08-26', DATE '2006-08-25', 'ST_CLERK', 50)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (135, DATE '2003-12-12', DATE '2007-12-11', 'ST_CLERK', 50)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (136, DATE '2004-02-06', DATE '2008-02-05', 'ST_CLERK', 50)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (137, DATE '1999-07-14', DATE '2003-07-13', 'ST_CLERK', 50)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (138, DATE '2001-10-26', DATE '2005-10-25', 'ST_CLERK', 50)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (139, DATE '2002-02-12', DATE '2006-02-11', 'ST_CLERK', 50)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (140, DATE '2002-04-06', DATE '2006-04-05', 'ST_CLERK', 50)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (141, DATE '1999-10-17', DATE '2003-10-16', 'ST_CLERK', 50)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (142, DATE '2001-01-29', DATE '2005-01-28', 'ST_CLERK', 50)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (143, DATE '2002-03-15', DATE '2006-03-14', 'ST_CLERK', 50)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (144, DATE '2002-07-09', DATE '2006-07-08', 'ST_CLERK', 50)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (145, DATE '2000-10-01', DATE '2004-09-30', 'SA_REP', 80)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (146, DATE '2001-01-05', DATE '2005-01-04', 'SA_REP', 80)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (147, DATE '2001-03-10', DATE '2005-03-09', 'SA_REP', 80)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (148, DATE '2003-10-15', DATE '2007-10-14', 'SA_REP', 80)
    INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (149, DATE '2004-01-29', DATE '2008-01-28', 'SA_REP', 80)
SELECT * FROM dual;

COMMIT;

-- =====================================================
-- FINAL VERIFICATION
-- =====================================================
SELECT 'JOBS' AS table_name, COUNT(*) AS record_count FROM jobs
UNION ALL
SELECT 'EMPLOYEES', COUNT(*) FROM employees
UNION ALL
SELECT 'JOB_HISTORY', COUNT(*) FROM job_history
UNION ALL
SELECT 'DEPARTMENTS', COUNT(*) FROM departments
UNION ALL
SELECT 'LOCATIONS', COUNT(*) FROM locations
UNION ALL
SELECT 'COUNTRIES', COUNT(*) FROM countries
UNION ALL
SELECT 'REGIONS', COUNT(*) FROM regions
ORDER BY table_name;

-- Test query to verify data
SELECT e.employee_id, e.first_name, e.last_name, j.job_title, e.salary
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
ORDER BY e.employee_id
FETCH FIRST 10 ROWS ONLY;

PROMPT '========================================='
PROMPT 'Data Insertion Complete!'
PROMPT 'Student: Sandesh Khatiwada (Sandeshcsit)'
PROMPT 'All Foreign Key Constraints Satisfied!'
PROMPT '========================================='