{{
  config(materialized='table')
}}

select *
from {{ source('tap_asana', 'tasks') }}
limit 5