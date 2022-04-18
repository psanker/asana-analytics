{{
  config(materialized='table')
}}

with unnested as (
  select
    gid,
    unnest(
      from_json(
        members,
        '[{"gid": "VARCHAR"}]'
      )
    ) as users
  from projects
)
select
  gid as proj_gid,
  users.gid as user_gid
from unnested