from datetime import datetime, timedelta
from airflow.decorators import dag, task
from airflow.operators.dummy import DummyOperator
from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.providers.postgres.operators.postgres import PostgresOperator

from operators import StageToRedshiftOperator, LoadFactOperator, LoadDimensionOperator, DataQualityOperator
from helpers import SqlQueries

default_args = {
    "owner": 'Sparkify',
    "depends_on_past": False,
    "start_date": datetime.now(),
    "retries": 3,
    "retry_delay": timedelta(minutes=5),
    "catchup": False,
    "email_on_retry": False,
}

@dag(default_args=default_args, schedule_interval='@hourly', catchup=False)
def final_project_dag():

    start_operator = DummyOperator(task_id='Begin_execution')

    tables_to_create = {
        "create_artists_table": "create_artists_table.sql",
        "create_songplays_table": "create_songplays_table.sql",
        "create_songs_table": "create_songs_table.sql",
        "create_staging_events_table": "create_staging_events_table.sql",
        "create_staging_songs_table": "create_staging_songs_table.sql",
        "create_time_table": "create_time_table.sql",
        "create_users_table": "create_users_table.sql",
    }

    create_table_tasks = []
    for task_id, sql_file in tables_to_create.items():
        task = PostgresOperator(
            task_id=task_id,
            postgres_conn_id="redshift",
            sql=sql_file,
        )
        create_table_tasks.append(task)



    stage_events_to_redshift = StageToRedshiftOperator(
        task_id='Stage_events',
        redshift_conn_id="redshift",
        aws_credentials_id="aws_credentials",
        table="staging_events",
        s3_bucket="gitongabretton",
        s3_key="log-data/",
        s3_path='s3://gitongabretton/log-data/',  
        region='us-east-1',
        json_option="s3://gitongabretton/log-json-path.json"  
    )

    
    stage_songs_to_redshift = StageToRedshiftOperator(
        task_id='Stage_songs',
        redshift_conn_id="redshift",
        aws_credentials_id="aws_credentials",
        table="staging_songs",
        s3_bucket="gitongabretton",
        s3_key="song-data/",
        s3_path='s3://gitongabretton/song-data/', 
        region='us-east-1',
        json_option='auto'  
    )

    
    load_songplays_table = LoadFactOperator(
        task_id='Load_songplays_fact_table',
        redshift_conn_id="redshift",
        sql=SqlQueries.songplay_table_insert,
        table='songplays',
        truncate=True,
    )

    load_user_dimension_table = LoadDimensionOperator(
        task_id='Load_user_dim_table',
        redshift_conn_id="redshift",
        table="users",
        sql=SqlQueries.user_table_insert,
        truncate=True,
    )

    load_song_dimension_table = LoadDimensionOperator(
        task_id='Load_song_dim_table',
        redshift_conn_id="redshift",
        table="songs",
        sql=SqlQueries.song_table_insert,
        truncate=True,
    )

    load_artist_dimension_table = LoadDimensionOperator(
        task_id='Load_artist_dim_table',
        redshift_conn_id="redshift",
        table="artists",
        sql=SqlQueries.artist_table_insert,
        truncate=True,
    )

    load_time_dimension_table = LoadDimensionOperator(
        task_id='Load_time_dim_table',
        redshift_conn_id="redshift",
        table="time",
        sql=SqlQueries.time_table_insert,
        truncate=True,
    )

    run_quality_checks = DataQualityOperator(
        task_id='Run_data_quality_checks',
        redshift_conn_id="redshift",
        tests=[
            {
                "table": "SELECT COUNT(*) FROM users WHERE userid IS NULL",
                "returnt": 0,
            },
        ]
    )

    end_operator = DummyOperator(task_id='Stop_execution')

    start_operator >> [
        stage_events_to_redshift,
        stage_songs_to_redshift,
    ] >> load_songplays_table
    load_songplays_table >> [
        load_user_dimension_table,
        load_song_dimension_table,
        load_artist_dimension_table,
        load_time_dimension_table,
    ] >> run_quality_checks >> end_operator

dag_instance = final_project_dag()
