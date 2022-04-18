from prefect import Flow
from prefect.tasks.shell import ShellTask

with Flow("elt") as f:
    elt_task = ShellTask(
        command="meltano run tap-asana target-duckdb dbt:run",
        stream_output=True,
    )

    docs_task = ShellTask(
        command='meltano invoke dbt docs generate',
        stream_output=True,
    )

    elt_task()
    docs_task()

if __name__ == '__main__':
    f.run()
