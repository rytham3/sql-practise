"""
- https://datalemur.com/questions/sql-average-deal-size-2
"""


WITH total_revenue AS (    
    SELECT customer_id,
           SUM(num_seats * yearly_seat_cost) AS customer_total_revenue
    FROM contracts 
    GROUP BY customer_id
)


SELECT 
      FLOOR(AVG(CASE WHEN cus.employee_count < 100 THEN customer_total_revenue END)) AS smb_avg,
      FLOOR(AVG(CASE WHEN cus.employee_count BETWEEN 100 AND 999 THEN customer_total_revenue END)) AS mid_market, 
      FLOOR(AVG(CASE WHEN cus.employee_count >= 1000 THEN customer_total_revenue END)) AS enterprise_avg
FROM total_revenue AS tr 
JOIN customers AS cus
      ON tr.customer_id = cus.customer_id

