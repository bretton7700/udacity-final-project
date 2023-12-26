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
# "login": "AKIATZS7MBBSL3CADLWH", 
# "password": "Wcey0jCuq815FWr0i5ybWuvT+cloiwv88UW26c+L", 
# "port": null, 
# "is_encrypted": "False", 
# "is_extra_encrypted": "False", 
# "extra_dejson": {}, 
# "get_uri": "aws://AKIATZS7MBBSL3CADLWH:Wcey0jCuq815FWr0i5ybWuvT+cloiwv88UW26c+L"
#}]
#
# Copy the value after "get_uri":
#
# For example: aws://AKIATZS7MBBSL3CADLWH:Wcey0jCuq815FWr0i5ybWuvT+cloiwv88UW26c+L
#
# TO-DO: Update the following command with the URI and un-comment it:
#
# airflow connections add aws_credentials --conn-uri 'aws://AKIATZS7MBBSL3CADLWH:Wcey0jCuq815FWr0i5ybWuvT+cloiwv88UW26c+L'
#
#
# TO-DO: run the follwing command and observe the JSON output: 
# airflow connections get redshift -o json
# 
# [{"id": "3", 
# "conn_id": "redshift", 
# "conn_type": "redshift", 
# "description": "", 
# "host": "default-workgroup.261119281252.us-east-1.redshift-serverless.amazonaws.com", 
# "schema": "dev", 
# "login": "awsuser", 
# "password": "aiGURU2023", 
# "port": "5439", 
# "is_encrypted": "False", 
# "is_extra_encrypted": "False", 
# "extra_dejson": {}, 
# "get_uri": "redshift://awsuser:aiGURU2023@default-workgroup.261119281252.us-east-1.redshift-serverless.amazonaws.com:5439/dev"}]
#
# Copy the value after "get_uri":
#
# For example: redshift://awsuser:aiGURU2023@default-workgroup.261119281252.us-east-1.redshift-serverless.amazonaws.com:5439/dev
#
# TO-DO: Update the following command with the URI and un-comment it:
#
# airflow connections add redshift --conn-uri 'redshift://awsuser:aiGURU2023@default-workgroup.261119281252.us-east-1.redshift-serverless.amazonaws.com:5439/dev'
#
# TO-DO: update the following bucket name to match the name of your S3 bucket and un-comment it:
#
# airflow variables set s3_bucket gitongabretton
#
# TO-DO: un-comment the below line:
#
# airflow variables set s3_prefix data-pipelines