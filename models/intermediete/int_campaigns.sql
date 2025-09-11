with adwords as (
    select
        date_date,
        paid_source,
        campaign_key,
        campaign_name,
        cast(ads_cost as float64) as ads_cost,
        cast(impression as int64) as impression,
        cast(click as int64) as click
    from {{ ref('stg_raw__adwords') }}
),

facebook as (
    select
        date_date,
        paid_source,
        campaign_key,
        campaign_name,
        cast(ads_cost as float64) as ads_cost,
        cast(impression as int64) as impression,
        cast(click as int64) as click
    from {{ ref('stg_raw__facebook') }}
),

bing as (
    select
        date_date,
        paid_source,
        campaign_key,
        campaign_name,
        cast(ads_cost as float64) as ads_cost,
        cast(impression as int64) as impression,
        cast(click as int64) as click
    from {{ ref('stg_raw__bing') }}
),

criteo as (
    select
        date_date,
        paid_source,
        campaign_key,
        campaign_name,
        cast(ads_cost as float64) as ads_cost,
        cast(impression as int64) as impression,
        cast(click as int64) as click
    from {{ ref('stg_raw__criteo') }}
)

select * from adwords
union all
select * from facebook
union all
select * from bing
union all
select * from criteo










/* With adwords as (
    Select 
        date_date,
        paid_source,
        campaign_key,
        campaign_name
        ads_cost,
        impression,
        click
    FROM {{ref('stg_raw__adwords')}}
),
facebook as (
    Select 
        date_date,
        paid_source,
        campaign_key,
        campaign_name
        ads_cost,
        impression,
        click
    FROM {{ref('stg_raw__facebook')}}
), 
bing as (
    Select 
        date_date,
        paid_source,
        campaign_key,
        campaign_name
        ads_cost,
        impression,
        click
    FROM {{ref('stg_raw__bing')}}
),
criteo as (
    Select 
        date_date,
        paid_source,
        campaign_key,
        campaign_name
        ads_cost,
        impression,
        click
    FROM {{ref('stg_raw__criteo')}}
) */

