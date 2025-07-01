WITH n_orders_daily AS (
    SELECT COUNT(order_id) AS daily_orders,
        strftime('%m', order_purchase_timestamp) AS mes,
        strftime('%d', order_purchase_timestamp) AS dia
    FROM
        tb_orders AS o
    WHERE
        o.order_purchase_timestamp >= '2017-01-01 00:00:00'
        AND
        o.order_purchase_timestamp < '2018-01-01 00:00:00'
    GROUP BY
        mes, dia
),
n_orders_bf AS (
    SELECT
        daily_orders AS bf_orders
    FROM
        n_orders_daily
    WHERE
        dia = '24'
    AND
        mes = '11'
)
SELECT
    bf_orders/AVG(daily_orders)
FROM
    n_orders_daily,
    n_orders_bf