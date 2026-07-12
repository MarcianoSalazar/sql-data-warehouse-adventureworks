

INSERT INTO silver.aw_customer (
    customer_id,
    person_id,
    store_id,
    territory_id
)
SELECT 
	customer_id,
    person_id,
    store_id,
    territory_id
FROM bronze.aw_customer
WHERE customer_id IS NOT NULL;


SELECT
    business_entity_id,
    NULLIF(TRIM(first_name), '') AS first_name,
    CASE
        WHEN NULLIF(TRIM(middle_name), '') IS NULL THEN NULL
        ELSE CONCAT(LEFT(TRIM(middle_name), 1), '.')
    END AS middle_name,    
    NULLIF(TRIM(last_name), '') AS last_name,
    NULLIF(TRIM(suffix), '') AS suffix
FROM bronze.aw_person

SELECT
    product_id,
    name,
    product_number,
    color, 
    standard_cost,
    list_price,
    size,
    product_subcategory_id
FROM bronze.aw_product

SELECT * FROM bronze.aw_person
