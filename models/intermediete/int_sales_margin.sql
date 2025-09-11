-- int_sales_margin.sql  (iskelet)
with s_sales as (
  select * from {{ ref('stg_raw__sales') }}   -- geçici olarak *
),
s_product as (
  select * from {{ ref('stg_raw__product') }} -- geçici olarak *
)
select *
from s_sales
-- join'i birazdan ekleyeceğiz
