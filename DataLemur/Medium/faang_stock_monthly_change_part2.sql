WITH monthly_prices_with_lag AS (      
      SELECT
            ticker,
            date,
            close,
            LAG(close) OVER(PARTITION BY ticker ORDER BY date) AS prev_month_close
      FROM stock_prices
)

SELECT 
      ticker,
      date,
      close,
      ROUND((close - prev_month_close) * 100 / prev_month_close, 2) AS intermnth_change_pct
FROM monthly_prices_with_lag
ORDER BY ticker, date;
