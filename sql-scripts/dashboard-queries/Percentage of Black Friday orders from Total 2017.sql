WITH total AS (
    SELECT
        count(DISTINCT order_id) as total_orders
    FROM
        tb_orders
    WHERE
        (tb_orders.order_purchase_timestamp >= '2017-01-01 00:00:00')
        AND
        (tb_orders.order_purchase_timestamp < '2018-01-01 00:00:00')
)
SELECT
    ROUND((count(order_id)* 1.0/total.total_orders), 4) AS pedidos_BF,
    printf('%.2f%%', (count(order_id)* 1.0/total.total_orders) * 100) AS pedidos_BF_porcentagem
FROM
    tb_orders as o,
    total
WHERE
    o.order_purchase_timestamp >= '2017-11-24 00:00:00'
    AND
    o.order_purchase_timestamp < '2017-11-25 00:00:00'