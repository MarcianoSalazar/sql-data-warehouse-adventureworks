

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
    first_name,
    middle_name,
    last_name,
    suffix
FROM bronze.aw_person

SELECT * FROM bronze.aw_person
