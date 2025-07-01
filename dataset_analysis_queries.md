# Sales time-series

## Is order_id unique?

```
select COUNT(distinct order_id), COUNT(order_id), COUNT(*) from tb_orders
```

<table>
  <thead>
    <tr>
      <th colspan="2">tb_orders.order_id entries</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>unique</td>
      <td>99441</td>
    </tr>
    <tr>
      <td>total</td>
      <td>99441</td>
    </tr>
  </tbody>
</table>

```
select COUNT(distinct order_id), COUNT(order_id), COUNT(*) from tb_order_items
```

<table>
  <thead>
    <tr>
      <th colspan="2">tb_order_items.order_id entries</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>unique</td>
      <td>98666</td>
    </tr>
    <tr>
      <td>total</td>
      <td>112650</td>
    </tr>
  </tbody>
</table>

```
select COUNT(distinct order_id), COUNT(order_id), COUNT(*) from tb_order_payments
```

<table>
  <thead>
    <tr>
      <th colspan="2">tb_order_payments.order_id entries</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>unique</td>
      <td>99440</td>
    </tr>
    <tr>
      <td>total</td>
      <td>103886</td>
    </tr>
  </tbody>
</table>

## Are all tb_orders.order_id in tb_order_items.order_id?

```
SELECT *
FROM (
SELECT 
    o.order_id AS order_id_orders,
    oi.order_id AS order_id_items
FROM tb_orders AS o
LEFT JOIN tb_order_items AS oi ON o.order_id = oi.order_id
UNION
SELECT 
    o.order_id AS order_id_orders,
    oi.order_id AS order_id_items
FROM tb_order_items AS oi
LEFT JOIN tb_orders AS o ON oi.order_id = o.order_id
WHERE o.order_id IS NULL
) AS full_join
WHERE (order_id_orders is NULL)
```

Returns nothing, so yes.

## Are all tb_orders_items.order_id in tb_orders.order_id?

```
SELECT COUNT(*)
FROM (
SELECT 
    o.order_id AS order_id_orders,
    oi.order_id AS order_id_items
FROM tb_orders AS o
LEFT JOIN tb_order_items AS oi ON o.order_id = oi.order_id
UNION
SELECT 
    o.order_id AS order_id_orders,
    oi.order_id AS order_id_items
FROM tb_order_items AS oi
LEFT JOIN tb_orders AS o ON oi.order_id = o.order_id
WHERE o.order_id IS NULL
) AS full_join
WHERE (order_id_items is NULL)
```

Returns 775 entries. So there are order ids with 0 items.

## Are all tb_orders.order_id in tb_order_payments.order_id?

```
select *
    from tb_orders as o
    left join tb_order_payments as op
    on o.order_id = op.order_id
    where op.order_id IS NULL
```

There is one missing entry in the payments table.

## Are all tb_order_payments.order_id in tb_orders.order_id?

```
select *
    from tb_order_payments
    left join tb_orders
    on tb_order_payments.order_id = tb_orders.order_id
    where tb_orders.order_id is null
```

Returns nothing so yes.

## What is the difference between total (price + freight_value) from order_items and total (payment_value) from order_payments?

```
SELECT 
  SUM(payment_value)
FROM
  tb_order_payments
```
Returns 16008872.12
```
SELECT
  (SUM(price) + SUM(freight_value))
FROM
  tb_order_items
```
Returns 15843553.24