WITH trd AS (
    SELECT 
        strftime('%Y', order_purchase_timestamp) AS ano,
        strftime('%m', order_purchase_timestamp) AS mes,
        strftime('%d', order_purchase_timestamp) as dia,
        SUM(p.payment_value) AS receita_diaria
    FROM
        tb_orders AS o
    LEFT JOIN
        tb_order_payments AS p
        ON o.order_id = p.order_id
    WHERE
        (o.order_purchase_timestamp >= '2017-01-01 00:00:00')
        AND
        (o.order_purchase_timestamp < '2018-01-01 00:00:00')
    GROUP BY
        ano, mes, dia
    HAVING NOT
        (dia = '24' AND mes = '11')
),
bf AS (
    SELECT 
        SUM(p.payment_value) AS receita_bf
    FROM
        tb_orders AS o
    LEFT JOIN 
        tb_order_payments AS p
        ON o.order_id = p.order_id
    WHERE
        o.order_purchase_timestamp >= '2017-11-24 00:00:00'
        AND
        o.order_purchase_timestamp <  '2017-11-25 00:00:00'
)
SELECT 
    bf.receita_bf / (SUM(trd.receita_diaria) * 1.0 / COUNT(*)) AS aumento_bf_vs_media,
    printf('%.2f%%', bf.receita_bf * 100.0 / (SUM(trd.receita_diaria) * 1.0 / COUNT(*))) AS aumento_bf_vs_media
FROM trd, bf