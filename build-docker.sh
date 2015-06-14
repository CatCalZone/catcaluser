#!/bin/bash
# set -x
VERSION=0.1.0
URL=https://github.com/CatCalZone/catcaluser/releases/download/v$VERSION/catcaluser-$VERSION.tar.gz

DEST=machines/phoenix/catcaluser.tar.gz

if [ "$1" = "-r" ] 
then
	curl --location -o $DEST $URL 
else
	cp rel/catcaluser/catcaluser-$VERSION.tar.gz $DEST
fi


cd machines/phoenix
sudo docker build -t catcal/catcaluser .
