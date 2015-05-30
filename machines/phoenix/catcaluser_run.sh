#!/bin/sh
# `/sbin/setuser catcal` runs the given command as the user `catcal`.
# If you omit that part, the command will be run as root.
echo "Starting catcaluser service"
exec /sbin/setuser catcal /catcaluser/bin/catcaluser foreground # >>/var/log/catcaluser.log 2>&1