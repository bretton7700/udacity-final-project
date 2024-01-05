#!/bin/bash
#
# TO-DO: run the follwing command and observe the JSON output: 
# airflow connections get aws_credentials -o json 
# 
#[{"id": "1", 
# "conn_id": "aws_credentials",
# "conn_type": "aws", 
# "description": "", 
# "host": "", 
# "schema": "", 
# "login": "key", 
# "password": "pass", 
# "port": null, 
# "is_encrypted": "False", 
# "is_extra_encrypted": "False", 
# "extra_dejson": {}, 
# "get_uri": "aws://key:pass"
#}]
#
# Copy the value after "get_uri":
#
# For example: aws://key:pass
#
# TO-DO: Update the following command with the URI and un-comment it:
#
# airflow connections add aws_credentials --conn-uri 'aws://key:pass'
#
#
# TO-DO: run the follwing command and observe the JSON output: 
# airflow connections get redshift -o json
# 
# [{"id": "3", 
# "conn_id": "redshift", 
# "conn_type": "redshift", 
# "description": "", 
# "host": "serveless", 
# "schema": "dev", 
# "login": "user", 
# "password": "pass", 
# "port": "5439", 
# "is_encrypted": "False", 
# "is_extra_encrypted": "False", 
# "extra_dejson": {}, 
# "get_uri": "redshift://user:pass@server:5439/dev"}]
#
# Copy the value after "get_uri":
#
# For example: 
# TO-DO: Update the following command with the URI and un-comment it:
#
# airflow connections add redshift --conn-uri 
#
# TO-DO: update the following bucket name to match the name of your S3 bucket and un-comment it:
#
# airflow variables set s3_bucket yourbucket
#
# TO-DO: un-comment the below line:
#
# airflow variables set s3_prefix data-pipelines
