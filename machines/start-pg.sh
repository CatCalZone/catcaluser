#!/bin/bash
#
# starts a new postgres container

pg_user=postgres
pg_passwd=postgres

sudo docker run --name catcaluser_db \
	-e POSTGRES_PASSWORD=$pg_passwd -e  POSTGRES_USER=$pg_user \
	-d -p 15432:5432 postgres

#echo "To (re)create the database do:"
#echo psql --host 127.0.0.1 --username=$pg_user -f sql/microimage.sql