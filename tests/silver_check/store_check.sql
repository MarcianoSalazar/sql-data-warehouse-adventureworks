
-- Check for NULLs
SELECT COUNT(*) AS null_count
FROM bronze.aw_store
WHERE business_entity_id IS NULL;

-- Check for duplicates
SELECT business_entity_id, COUNT(*) AS duplicate_count
FROM bronze.aw_store
GROUP BY business_entity_id
HAVING COUNT(*) > 1;



-- Check for NULLs/blanks
SELECT COUNT(*) AS null_or_blank_count
FROM bronze.aw_store
WHERE name IS NULL OR TRIM(name) = '';

-- Check for unwanted spaces
SELECT name
FROM bronze.aw_store
WHERE name != TRIM(name);
