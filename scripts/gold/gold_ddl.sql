
-- Create Dimension: gold.dim_customers
IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
    DROP VIEW gold.dim_customers;
GO

CREATE VIEW gold.dim_customers AS 
SELECT
    ROW_NUMBER() OVER (ORDER BY customer_id) AS customer_key,
    c.customer_id,
    CASE    
        WHEN c.store_id IS NOT NULL THEN st.name
        ELSE TRIM(CONCAT(
            p.first_name, ' ',
            ISNULL(p.middle_name + ' ', ''),
            p.last_name,
            ISNULL(' ' + p.suffix, '')
        ))
    END AS name,
    CASE
        WHEN store_id IS NOT NULL THEN 'Store'
        WHEN person_id IS NOT NULL THEN 'Individual'
        ELSE 'Unknown'
    END AS customer_type
FROM silver.aw_customer AS c
LEFT JOIN silver.aw_person AS p 
    ON c.person_id = p.business_entity_id
LEFT JOIN silver.aw_store AS st 
    ON c.store_id = st.business_entity_id
GO



-- Create Dimension: gold.dim_products
IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
    DROP VIEW gold.dim_products;
GO

CREATE VIEW gold.dim_products AS 
SELECT 
    ROW_NUMBER() OVER (ORDER BY product_id) AS product_key,
    p.product_id ,
    p.name AS product_name,
    p.product_number,
    p.color,
    p.size,
    p.standard_cost,
    p.list_price,
    psc.name AS subcategory,
    pc.name AS category
FROM silver.aw_product AS p
INNER JOIN silver.aw_product_subcategory AS psc
    ON p.product_subcategory_id = psc.product_subcategory_id
INNER JOIN silver.aw_product_category AS pc
    ON psc.product_category_id = pc.product_category_id;
GO



-- Create Dimension: gold.dim_products
IF OBJECT_ID('gold.dim_sales_persons', 'V') IS NOT NULL
    DROP VIEW gold.dim_sales_persons;
GO
CREATE VIEW gold.dim_sales_persons AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY sp.business_entity_id) AS sales_person_key,
    sp.business_entity_id AS sales_person_id,
    TRIM(CONCAT(p.first_name, ' ', 
        ISNULL(p.middle_name + ' ', ''),
        p.last_name, ' ', 
        ISNULL(p.suffix, '')
    )) AS full_name,
    e.job_title
FROM silver.aw_sales_person AS sp
LEFT JOIN silver.aw_employee AS e
    ON sp.business_entity_id = e.business_entity_id
LEFT JOIN silver.aw_person AS p
    ON sp.business_entity_id = p.business_entity_id;
GO


