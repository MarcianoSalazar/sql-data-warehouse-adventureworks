

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
    last_name,
    suffix
FROM bronze.aw_person

SELECT * FROM bronze.aw_person
