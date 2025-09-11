{{ config(materialized='table') }}
with o as (
  select
    orders_id,
    date_date,
    cast(revenue       as float64) as revenue,
    cast(quantity      as int64)   as qty,
    cast(purchase_cost as float64) as purchase_cost,
    cast(margin        as float64) as margin
  from {{ ref('int_orders_margin') }}
),
op as (
  select
    orders_id,
    date_date,
    cast(operational_margin as float64) as operational_margin,
    cast(shipping_fee       as float64) as shipping_fee,
    cast(logcost            as float64) as logcost,
    cast(ship_cost          as float64) as ship_cost
  from {{ ref('int_orders_operational') }}
)
select
  o.date_date,
  count(distinct o.orders_id)                  as txn_count,
  round(sum(o.revenue), 2)                     as total_revenue,
  round(avg(o.revenue), 2)                     as avg_basket,
  round(sum(op.operational_margin), 2)         as operational_margin,
  round(sum(o.purchase_cost), 2)               as total_purchase_cost,
  round(sum(op.shipping_fee), 2)               as total_shipping_fees,
  round(sum(op.logcost + op.ship_cost), 2)     as total_logistics_costs,
  sum(o.qty)                                   as total_qty
from o
left join op using (orders_id, date_date)
WHERE o.date_date is null

group by 1
order by 1
