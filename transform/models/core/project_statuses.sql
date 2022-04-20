{{
  config(materialized='table')
}}

with filtered as (
  select
    gid as project_gid,
    current_status
  from {{ source('tap_asana', 'projects') }}
  where current_status not null
),
jsond as (
  select
    project_gid,
    json(current_status) as current_status
  from filtered
)
select
  current_status->>'$.gid' as gid,
  project_gid,
  current_status->>'$.author.gid' as author,
  current_status->>'$.color' as status_color,
  current_status->>'$.created_at' as created_at,
  current_status->>'$.created_by.gid' as created_by,
  current_status->>'$.modified_at' as modified_at,
  current_status->>'$.title' as title,
  current_status->>'$.text' as status_text
from jsond