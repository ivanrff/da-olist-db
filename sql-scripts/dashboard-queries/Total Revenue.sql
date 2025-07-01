SELECT 
    SUM(p.payment_value) AS total_payment_2017
FROM
    tb_orders o
LEFT JOIN
    tb_order_payments p
    ON o.order_id = p.order_id
WHERE
    o.order_purchase_timestamp BETWEEN '2017-01-01 00:00:00' AND '2017-12-31 23:59:59'