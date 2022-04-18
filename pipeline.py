from prefect import Flow
from prefect.tasks.shell import ShellTask

with Flow("elt") as f:
    elt_task = ShellTask(
        command="meltano run tap-asana target-duckdb dbt:run",
    )

    elt_task()

if __name__ == '__main__':
    f.run()
