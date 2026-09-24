CREATE DATABASE Olist;
USE Olist;


SELECT 
	customer_unique_id AS ID_unico,
	order_purchase_timestamp AS fecha_compra,
	SUM(CAST(price AS DECIMAL(10,2))) AS price
FROM dbo.olist_customers_dataset AS c
JOIN dbo.olist_orders_dataset AS o
ON c.customer_id = o.customer_id
JOIN dbo.olist_order_items_dataset AS oi
ON o.order_id = oi.order_id

WHERE o.order_purchase_timestamp >= DATEADD(
    DAY,
    -30,
    (SELECT MAX(order_purchase_timestamp)
	FROM dbo.olist_orders_dataset AS o2
	JOIN dbo.olist_order_items_dataset AS oi2
	ON o2.order_id = oi2.order_id
	))

GROUP BY 
	customer_unique_id,
	order_purchase_timestamp

ORDER BY order_purchase_timestamp desc
;

