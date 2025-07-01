select count(DISTINCT order_id) from tb_orders

where (tb_orders.order_purchase_timestamp > '2017-01-01 00:00:00')
and (tb_orders.order_purchase_timestamp < '2018-01-01 00:00:00')