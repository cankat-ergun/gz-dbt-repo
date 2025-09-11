-- int_sales_margin.sql (iskelet)
-- öneri: görünürlük için view:
{{ config(materialized='view') }}

with s_sales as (
  select
    orders_id,
    cast(pdt_id as int64)           as product_id,
    cast(quantity as int64)         as qty,
    cast(revenue as numeric)        as revenue,
    date_date
  from {{ ref('stg_raw__sales') }}
),
s_product as (
  select
    cast(products_id as int64)      as product_id,
    cast(purchse_price as numeric)  as purchase_price
  from {{ ref('stg_raw__product') }}
)


select
    s.date_date,
    s.orders_id,
    s.product_id,
    s.qty,
    s.revenue,
    p.purchase_price,
    round(s.qty * p.purchase_price, 2) as purchase_cost,
    round(s.revenue - (s.qty * p.purchase_price), 2) as margin
from s_sales s
left join s_product p
  on s.product_id = p.product_id

