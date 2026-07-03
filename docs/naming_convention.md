# Naming Conventions

This document outlines the naming conventions used for schemas, tables, views, columns, and other objects in the AdventureWorks Sales Data Warehouse.

## Table of Contents
- [General Principles](#general-principles)
- [Table Naming Conventions](#table-naming-conventions)
  - [Bronze Rules](#bronze-rules)
  - [Silver Rules](#silver-rules)
  - [Gold Rules](#gold-rules)
- [Column Naming Conventions](#column-naming-conventions)
  - [Surrogate Keys](#surrogate-keys)
  - [Technical Columns](#technical-columns)
- [Stored Procedure Naming](#stored-procedure-naming)

## General Principles

- **Naming Conventions**: Use snake_case, with lowercase letters and underscores (_) to separate words.
- **Language**: Use English for all names.
- **Avoid Reserved Words**: Do not use SQL reserved words as object names.
- **Source System**: This project uses a single source system, AdventureWorks OLTP, referred to as `aw` throughout the naming pattern.

## Table Naming Conventions

### Bronze Rules

All names must start with the source system name, and table names must match their original source entity names without renaming.

`<sourcesystem>_<entity>`

- `<sourcesystem>`: Name of the source system (`aw` for AdventureWorks).
- `<entity>`: Exact table name from the source system, translated to snake_case.

Examples:
- `aw_sales_order_header` → Raw data from Sales.SalesOrderHeader
- `aw_sales_order_detail` → Raw data from Sales.SalesOrderDetail
- `aw_customer` → Raw data from Sales.Customer
- `aw_person` → Raw data from Person.Person
- `aw_product` → Raw data from Production.Product
- `aw_product_subcategory` → Raw data from Production.ProductSubcategory
- `aw_product_category` → Raw data from Production.ProductCategory
- `aw_sales_territory` → Raw data from Sales.SalesTerritory

### Silver Rules

All names must start with the source system name, and table names must match their original source entity names without renaming. Only the content changes (cleaned/standardized); the naming pattern stays the same as Bronze.

`<sourcesystem>_<entity>`

- `<sourcesystem>`: Name of the source system (`aw` for AdventureWorks).
- `<entity>`: Exact table name from the source system, translated to snake_case.

Examples:
- `aw_sales_order_header` → Cleaned order header data
- `aw_sales_order_detail` → Cleaned order line-item data
- `aw_customer` → Cleaned customer data
- `aw_person` → Cleaned person/name data
- `aw_product` → Cleaned product data
- `aw_product_subcategory` → Cleaned product subcategory data
- `aw_product_category` → Cleaned product category data
- `aw_sales_territory` → Cleaned territory data

### Gold Rules

All names must use meaningful, business-aligned names for tables/views, starting with the category prefix.

`<category>_<entity>`

- `<category>`: Describes the role of the object, such as `dim` (dimension) or `fact` (fact table).
- `<entity>`: Descriptive name of the object, aligned with the business domain (e.g., customer, product, sales).

Examples:
- `dim_customer` → Dimension view for customer data.
- `dim_product` → Dimension view for product data (includes category/subcategory hierarchy).
- `dim_date` → Dimension view for date/calendar attributes.
- `dim_territory` → Dimension view for sales territory/region data.
- `fact_sales` → Fact view containing sales order transactions.

#### Glossary of Category Patterns

| Pattern | Meaning | Example(s) |
|---|---|---|
| `dim_` | Dimension table/view | `dim_customer`, `dim_product` |
| `fact_` | Fact table/view | `fact_sales` |
| `report_` | Report table/view (optional, for aggregated reporting) | `report_sales_monthly`, `report_customer_summary` |

## Column Naming Conventions

### Surrogate Keys

All primary keys in dimension tables/views must use the suffix `_key`.

`<table_name>_key`

- `<table_name>`: Refers to the name of the table or entity the key belongs to (singular form).
- `_key`: A suffix indicating that this column is a surrogate key, generated within the warehouse (e.g., via ROW_NUMBER()), not the original source ID.

Examples:
- `customer_key` → Surrogate key in `dim_customer`.
- `product_key` → Surrogate key in `dim_product`.
- `territory_key` → Surrogate key in `dim_territory`.
- `date_key` → Surrogate key in `dim_date`.

Note: Original source identifiers (e.g., `CustomerID`, `ProductID`) are preserved as separate columns (e.g., `customer_id`, `product_id`) for traceability back to the source, but are not used as the join key in the Gold layer — the surrogate `_key` columns are used instead.

### Technical Columns

All technical/metadata columns must start with the prefix `dwh_`, followed by a descriptive name indicating the column's purpose.

`dwh_<column_name>`

- `dwh`: Prefix exclusively for system-generated metadata.
- `<column_name>`: Descriptive name indicating the column's purpose.

Examples:
- `dwh_load_date` → System-generated column storing the date/time a record was loaded into the layer.
- `dwh_source_system` → System-generated column storing the originating source system name (`aw`).

## Stored Procedure Naming

All stored procedures used for loading data must follow the naming pattern:

`load_<layer>`

- `<layer>`: Represents the layer being loaded — `bronze`, `silver`, or `gold`.

Examples:
- `load_bronze` → Stored procedure for loading data into the Bronze layer.
- `load_silver` → Stored procedure for loading data into the Silver layer.

Note: The Gold layer uses views (not tables), so no `load_gold` procedure is needed — Gold objects are created via `CREATE VIEW` statements instead.
