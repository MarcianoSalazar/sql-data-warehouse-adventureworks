/*
--------------------------------------------
DDL Scripts: Create Bronze Tables
--------------------------------------------
Script Purpose:
    This script create tables in the bronze 
    schema and drop the table if it is 
    already exists

Note:
    Run this script to redefine the structure
    of bronze tables
---------------------------------------------
*/


IF OBJECT_ID('bronze.aw_customer', 'U') IS NOT NULL
    DROP TABLE bronze.aw_customer;
GO
CREATE TABLE bronze.aw_customer (
    customer_id     INT,
    person_id       INT,
    store_id        INT,
    territory_id    INT,
    account_number  VARCHAR(10),
    rowguid         UNIQUEIDENTIFIER,
    modified_date   DATETIME
);
GO


IF OBJECT_ID('bronze.aw_person', 'U') IS NOT NULL
    DROP TABLE bronze.aw_person
GO
CREATE TABLE bronze.aw_person (
    business_entity_id          INT,
    person_type                 NCHAR(2),
    name_style                  BIT,
    title                       NVARCHAR(8),
    first_name                  NVARCHAR(50),
    middle_name                 NVARCHAR(50),
    last_name                   NVARCHAR(50),
    suffix                      NVARCHAR(10),
    email_promotion             INT,
    additional_contact_info     XML,
    demographics                XML,
    rowguid                     UNIQUEIDENTIFIER,
    modified_date               DATE
);
GO


IF OBJECT_ID('bronze.aw_product', 'U') IS NOT NULL
    DROP TABLE bronze.aw_product
GO

CREATE TABLE bronze.aw_product (
    product_id                 INT,
    name                       NVARCHAR(50),
    product_number             NVARCHAR(25),
    make_flag                  BIT,
    finished_goods_flag        BIT,
    color                      NVARCHAR(15),
    safety_stock_level         SMALLINT,
    reorder_point              SMALLINT,
    standard_cost              MONEY,
    list_price                 MONEY,
    size                       NVARCHAR(5),
    size_unit_measure_code     NCHAR(3),
    weight_unit_measure_code   NCHAR(3),
    weight                     DECIMAL(8,2),
    days_to_manufacture        INT,
    product_line               NCHAR(2),
    class                      NCHAR(2),
    style                      NCHAR(2),
    product_subcategory_id     INT,
    product_model_id           INT,
    sell_start_date            DATETIME,
    sell_end_date              DATETIME,
    discontinued_date          DATETIME,
    rowguid                    UNIQUEIDENTIFIER,
    modified_date              DATETIME
);
GO



IF OBJECT_ID('bronze.aw_product_subcategory', 'U') IS NOT NULL
    DROP TABLE bronze.aw_product_subcategory
GO

CREATE TABLE bronze.aw_product_subcategory (
    product_subcategory_id     INT,
    product_category_id        INT,
    name                       NVARCHAR(50),
    rowguid                    UNIQUEIDENTIFIER,
    modified_date              DATETIME
);
GO


IF OBJECT_ID('bronze.aw_product_category', 'U') IS NOT NULL
    DROP TABLE bronze.aw_product_category
GO

CREATE TABLE bronze.aw_product_category (
    product_category_id        INT,
    name                       NVARCHAR(50),
    rowguid                    UNIQUEIDENTIFIER,
    modified_date              DATETIME
);
GO


IF OBJECT_ID('bronze.aw_sales_territory', 'U') IS NOT NULL
    DROP TABLE bronze.aw_sales_territory
GO

CREATE TABLE bronze.aw_sales_territory (
    territory_id               INT,
    name                       NVARCHAR(50),
    country_region_code        NVARCHAR(3),
    group_name                 NVARCHAR(50),
    sales_ytd                  MONEY,
    sales_last_year            MONEY,
    cost_ytd                   MONEY,
    cost_last_year             MONEY,
    rowguid                    UNIQUEIDENTIFIER,
    modified_date              DATETIME
);
GO


IF OBJECT_ID('bronze.aw_sales_person', 'U') IS NOT NULL
    DROP TABLE bronze.aw_sales_person
GO

CREATE TABLE bronze.aw_sales_person (
    business_entity_id         INT,
    territory_id               INT,
    sales_quota                MONEY,
    bonus                      MONEY,
    commission_pct             SMALLMONEY,
    sales_ytd                  MONEY,
    sales_last_year            MONEY,
    rowguid                    UNIQUEIDENTIFIER,
    modified_date              DATETIME
);
GO


IF OBJECT_ID('bronze.aw_employee', 'U') IS NOT NULL
    DROP TABLE bronze.aw_employee
GO

CREATE TABLE bronze.aw_employee (
    business_entity_id         INT,
    national_id_number         NVARCHAR(15),
    login_id                   NVARCHAR(256),
    organization_node          HIERARCHYID,
    organization_level         SMALLINT,
    job_title                  NVARCHAR(50),
    birth_date                 DATE,
    marital_status             NCHAR(1),
    gender                     NCHAR(1),
    hire_date                  DATE,
    salaried_flag              BIT,
    vacation_hours             SMALLINT,
    sick_leave_hours           SMALLINT,
    current_flag               BIT,
    rowguid                    UNIQUEIDENTIFIER,
    modified_date              DATETIME
);
GO


IF OBJECT_ID('bronze.aw_sales_order_header', 'U') IS NOT NULL
    DROP TABLE bronze.aw_sales_order_header
GO

CREATE TABLE bronze.aw_sales_order_header (
    sales_order_id           INT,
    revision_number          TINYINT,
    order_date               DATETIME,
    due_date                 DATETIME,
    ship_date                DATETIME,
    status                   TINYINT,
    online_order_flag        BIT,
    sales_order_number       NVARCHAR(25),
    purchase_order_number    NVARCHAR(25),
    account_number           NVARCHAR(15),
    customer_id              INT,
    sales_person_id          INT,
    territory_id             INT,
    bill_to_address_id       INT,
    ship_to_address_id       INT,
    ship_method_id           INT,
    credit_card_id           INT,
    credit_card_approv_code  VARCHAR(15),
    currency_rate_id         INT,
    sub_total                MONEY,
    tax_amt                  MONEY,
    freight                  MONEY,
    total_due                MONEY,
    comment                  NVARCHAR(128),
    rowguid                  UNIQUEIDENTIFIER,
    modified_date            DATETIME
);
GO
