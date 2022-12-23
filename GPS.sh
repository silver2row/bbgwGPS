#!/bin/bash

sudo gpsd /dev/ttyS2 -F /var/run/gpsd.sock

sleep 60

sudo gpspipe -r -d -l -o /home/debian/data/data.400.nmea
