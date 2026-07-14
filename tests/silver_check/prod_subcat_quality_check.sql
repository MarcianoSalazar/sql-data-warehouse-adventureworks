
-- Check Duplicates
SELECT 
    name,
    COUNT(*)
FROM bronze.aw_product_subcategory
GROUP BY name
HAVING COUNT(*) > 1;

-- Check Nulls
SELECT 
    COUNT(name) AS total_null
FROM bronze.aw_product_subcategory
WHERE name IS NULL;


-- Orphan Check
SELECT 
    psc.product_subcategory_id,
    psc.product_category_id
FROM bronze.aw_product_subcategory AS psc
LEFT JOIN bronze.aw_product_category AS pc
    ON psc.product_category_id = pc.product_category_id
WHERE psc.product_category_id IS NOT NULL
    AND pc.product_category_id IS NULL;


-- Check Unwanted Spaces
SELECT 
    name
FROM bronze.aw_product_subcategory
WHERE name != TRIM(name)
