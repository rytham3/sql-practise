"""
- Question link - https://datalemur.com/questions/invalid-search-pct
"""



WITH c1 AS (    
    SELECT *,
           (num_search * invalid_result_pct / 100.0) AS invalid_searches
    FROM search_category 
    WHERE num_search IS NOT NULL AND invalid_result_pct IS NOT NULL
),

c2 AS (
    SELECT 
          country,
          SUM(num_search) AS total_searches,
          SUM(invalid_searches) AS total_invalid_searches
    FROM c1
    GROUP BY country
)

SELECT 
      country,
      total_searches,
      ROUND((total_invalid_searches*100.0/ total_searches), 2) AS invalid_search_pct
FROM c2
ORDER BY country
