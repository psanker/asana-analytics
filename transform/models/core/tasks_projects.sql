{{
  config(materialized='table')
}}

with unnested as (
  select
    gid,
    unnest(
      from_json(
        first(projects),
        '[{"gid": "VARCHAR"}]'
      )
    ) as projs
  from {{ source('tap_asana', 'tasks') }}
  group by gid
)
select
  gid as task_gid,
  projs.gid as proj_gid
from unnested