# ELT Pipeline Demo

This is a very basic ELT pipeline, ingesting data from Asana and then creating models on a local [DuckDB](https://duckdb.org) database with [dbt](http://getdbt.com). Orchestrated with [Prefect](https://prefect.io) and EL managed by [Meltano](https://meltano.com).

## Setup

```sh
git clone https://github.com/psanker/asana-analytics
cd asana-analytics
pipenv install
pipenv shell
meltano install
```

## Running

```sh
pipenv shell
prefect run -p pipeline.py

# or
pipenv run prefect run -p pipeline.py
```