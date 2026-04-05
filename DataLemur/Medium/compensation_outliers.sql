WITH avg_salary AS (
      SELECT title,
             ROUND(AVG(salary),2) AS avg_salary
      FROM employee_pay
      GROUP BY title
)

SELECT 
      e.employee_id,
      e.salary,
      CASE 
          WHEN e.salary > (2 * a.avg_salary) THEN 'Overpaid' 
          WHEN e.salary < (0.5 * a.avg_salary) THEN 'Underpaid'
      END AS status
FROM employee_pay AS e 
JOIN avg_salary AS a 
    ON e.title = a.title
WHERE e.salary > (2*a.avg_salary) OR e.salary < (0.5 * a.avg_salary)
