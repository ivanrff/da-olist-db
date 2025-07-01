WITH t AS (
    SELECT SUM(p.payment_value) AS total_revenue
    FROM
        tb_orders AS o
    LEFT JOIN
        tb_order_payments AS p
        ON o.order_id = p.order_id

    WHERE
        o.order_purchase_timestamp >= '2017-01-01 00:00:00'
        AND
        o.order_purchase_timestamp < '2018-01-01 00:00:00'
)
SELECT SUM(p.payment_value)/t.total_revenue AS receita_BF,
    printf('%.2f%%', SUM(p.payment_value)/t.total_revenue * 100) AS receita_BF_porcentagem
FROM
    tb_orders AS o
LEFT JOIN
    tb_order_payments AS p
    ON o.order_id = p.order_id
CROSS JOIN
    t
WHERE
    o.order_purchase_timestamp >= '2017-11-24 00:00:00'
    AND
    o.order_purchase_timestamp < '2017-11-25 00:00:00'