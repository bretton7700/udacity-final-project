# Airflow DAG for Sparkify Data Pipeline

## Overview
This document details the Airflow Directed Acyclic Graph (DAG) for automating the Sparkify music streaming service's data workflow. The DAG facilitates extracting, loading, and transforming data from AWS S3 into an AWS Redshift data warehouse.

## 📆 DAG Specifications
- **DAG Name:** `final_project_dag`
- **Schedule:** Hourly Execution
- **Start Date:** Current date (from DAG instantiation)
- **Catchup:** False (No backfilling)
- **Retry Policy:** 3 retries, 5-minute intervals

## 🚀 Tasks Breakdown
1. **Begin Execution**: Start of the DAG process. 
    - *Operator:* `DummyOperator`
2. **Table Creation**: Sequential creation of necessary Redshift tables.
    - *Operators:* Multiple `PostgresOperator` instances
3. **Staging Events/Songs to Redshift**: Loading log and song data from S3 to staging tables.
    - *Operators:* `StageToRedshiftOperator`
4. **Fact and Dimension Table Loads**: Populating fact and dimension tables from staging data.
    - *Operators:* `LoadFactOperator`, `LoadDimensionOperator`
5. **Data Quality Checks**: Ensuring data integrity and accuracy.
    - *Operator:* `DataQualityOperator`
6. **End Execution**: Concluding the DAG process.
    - *Operator:* `DummyOperator`

## 🛠️ Custom Operators
- **StageToRedshiftOperator**: Transfers data from S3 to Redshift.
- **LoadFactOperator**: Loads data into fact tables.
- **LoadDimensionOperator**: Loads data into dimension tables.
- **DataQualityOperator**: Validates the quality of the data loaded.

## 📄 SQL Helper
- **SqlQueries**: Contains SQL statements for data insertion, located in the `helpers` module.

## 🗂️ File Organization
- `dags/final_project_dag.py`: Main DAG definition.
- `plugins/operators/`: Custom operators.
- `plugins/helpers/sql_queries.py`: SQL queries helper.
- `sql/`: SQL scripts for table creation.

## ⚙️ Setup and Execution
1. Place the DAG file in the `dags` folder of your Airflow environment.
2. Custom operators should be in `plugins/operators`.
3. SQL helper class should be in `plugins/helpers`.
4. Ensure SQL creation scripts are accessible to Airflow.
5. Configure Airflow with AWS and Redshift connections.
6. Initiate the DAG via Airflow's UI or CLI.

## 📝 Important Notes
- Confirm the setup of AWS credentials and Redshift connections in Airflow.
- The S3 bucket `gitongabretton` and data paths should be correctly configured.
- Adjust the `start_date` and other `default_args` as needed for your project.
