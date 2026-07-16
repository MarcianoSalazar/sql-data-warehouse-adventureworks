
-- Check Duplicates
SELECT sales_person_id, COUNT(*) 
FROM gold.dim_sales_persons
GROUP BY sales_person_id
HAVING COUNT(*) > 1;

-- Check NULL full_name or job_title (orphan risk because of LEFT JOIN)
SELECT sales_person_key, sales_person_id, full_name, job_title
FROM gold.dim_sales_persons
WHERE full_name IS NULL OR TRIM(full_name) = ''
   OR job_title IS NULL;

-- Check for Double spaces
SELECT sales_person_id, full_name
FROM gold.dim_sales_persons
WHERE full_name LIKE '%  %'; 
