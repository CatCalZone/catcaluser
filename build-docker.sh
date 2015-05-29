#!/bin/bash

VERSION=0.0.1
cp rel/catcaluser/catcaluser-$VERSION.tar.gz machines/phoenix/catcaluser.tar.gz

cd machines/phoenix
sudo docker build -t catcal/catcaluser .
