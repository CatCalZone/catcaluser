#!/bin/bash

sudo docker run -t -i \
	-p 4001:4001 \
	--link catcaluser_db:db \
	catcal/catcaluser $*

