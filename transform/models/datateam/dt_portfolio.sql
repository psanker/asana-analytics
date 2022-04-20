{{
  config(materialized='view')
}}

with sel_tasks as (
  select
    task_gid
  from {{ ref('tasks_projects') }}
  where proj_gid = '1200054901504374'
),
workflow_tasks_projs as (
  select
    tp.task_gid as task_gid,
    proj_gid
  from {{ ref('tasks_projects') }} as tp
  join sel_tasks on (tp.task_gid = sel_tasks.task_gid)
  where proj_gid <> '1200054901504374'
),
task_completion as (
  select
    task_gid,
    completed
  from {{ source('tap_asana', 'tasks') }} as t
  join sel_tasks on (t.gid = sel_tasks.task_gid)
)
select
  w.proj_gid as proj_gid,
  first(name) as name,
  first(status_color) as status,
  sum(completed) / count(completed) as completeness
from workflow_tasks_projs as w
join {{ source('tap_asana', 'projects') }} as projs on (projs.gid = w.proj_gid)
left join {{ ref('project_statuses') }} as s on (s.project_gid = w.proj_gid)

group by 1