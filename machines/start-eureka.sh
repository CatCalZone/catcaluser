#!/bin/bash

if [ -d applications ] 
then
	echo "mounting applications directory"
else
	echo "applications directory must be available! ==> cd to MCRS repo!"
	exit 1
fi

if [ -f "applications/supportingServices/discoveryService/build/libs/discoveryService-0.1.0.jar" ]
then
	echo "JAR file available"
else
	echo "looks bad, will fail"
fi


sudo docker run -t -i \
	-p 8761:8761 \
	--name discoveryservice \
	-v `pwd`/applications:/applications \
	catcal/discoveryservice $*
