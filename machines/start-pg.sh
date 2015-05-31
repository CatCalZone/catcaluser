#!/bin/bash
#
# starts a new postgres container

pg_user=catcal
pg_passwd=catcal

sudo docker run --name catcaluser_db \
	-e POSTGRES_PASSWORD=$pg_passwd -e  POSTGRES_USER=$pg_user \
	-d -p 15432:5432 postgres
