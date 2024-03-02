SELECT
  line_item_product_code,
  line_item_usage_account_id,
  DATE_FORMAT(line_item_usage_start_date,'%Y-%m') AS date_line_item_usage_start_date,
  line_item_usage_type,
  product_from_location,
  product_to_location,
  product_product_family,
  line_item_resource_id,
  SUM(CAST(line_item_usage_amount AS DOUBLE)) AS sum_line_item_usage_amount,
  SUM(CAST(line_item_unblended_cost AS DECIMAL(16,8))) AS sum_line_item_unblended_cost
FROM
  "TABELA CUR"  #Substituir
WHERE
"line_item_usage_start_date" BETWEEN FROM_ISO8601_TIMESTAMP('2024-01-01T00:00:00') AND FROM_ISO8601_TIMESTAMP('2024-01-31T23:59:59')
   AND product_product_family = 'Data Transfer'
   AND line_item_line_item_type  IN ('DiscountedUsage', 'Usage', 'SavingsPlanCoveredUsage')
  GROUP BY
   line_item_product_code,
   line_item_usage_account_id,
   DATE_FORMAT(line_item_usage_start_date, '%Y-%m'),
   line_item_resource_id,
   line_item_usage_type,
   product_from_location,
   product_to_location,
   product_product_family
  ORDER BY
   sum_line_item_unblended_cost DESC;