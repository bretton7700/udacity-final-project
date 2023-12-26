Airflow DAG for Sparkify Data Pipeline
Overview
This document details the Airflow Directed Acyclic Graph (DAG) created for automating the Sparkify music streaming service's data workflow. The DAG facilitates the extraction, loading, and transformation of data from AWS S3 into an AWS Redshift data warehouse.

📆 DAG Specifications
DAG Name: final_project_dag
Schedule: Hourly Execution
Start Date: Current date (from DAG instantiation)
Catchup: False (No backfilling)
Retry Policy: 3 retries, 5-minute intervals
🚀 Tasks Breakdown
Begin Execution: Start of the DAG process.
Operator: DummyOperator
Table Creation: Sequential creation of necessary Redshift tables.
Operators: Multiple PostgresOperator instances
Staging Events/Songs to Redshift: Loading log and song data from S3 to staging tables.
Operators: StageToRedshiftOperator
Fact and Dimension Table Loads: Populating fact and dimension tables from staging data.
Operators: LoadFactOperator, LoadDimensionOperator
Data Quality Checks: Ensuring data integrity and accuracy.
Operator: DataQualityOperator
End Execution: Concluding the DAG process.
Operator: DummyOperator
🛠️ Custom Operators
StageToRedshiftOperator: Transfers data from S3 to Redshift.
LoadFactOperator: Loads data into fact tables.
LoadDimensionOperator: Loads data into dimension tables.
DataQualityOperator: Validates the quality of the data loaded.
📄 SQL Helper
SqlQueries: Contains SQL statements for data insertion, located in the helpers module.
🗂️ File Organization
dags/final_project_dag.py: Main DAG definition.
plugins/operators/: Custom operators.
plugins/helpers/sql_queries.py: SQL queries helper.
sql/: SQL scripts for table creation.
⚙️ Setup and Execution
Place the DAG file in the dags folder of your Airflow environment.
Custom operators should be in plugins/operators.
SQL helper class should be in plugins/helpers.
Ensure SQL creation scripts are accessible to Airflow.
Configure Airflow with AWS and Redshift connections.
Initiate the DAG via Airflow's UI or CLI.
📝 Important Notes
Confirm the setup of AWS credentials and Redshift connections in Airflow.
The S3 bucket gitongabretton and data paths should be correctly configured.
Adjust the start_date and other default_args as needed for your project.