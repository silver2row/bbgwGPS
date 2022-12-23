#!/bin/bash

config-pin p9.21 uart
config-pin p9.22 uart

sudo systemctl restart gpsd.service
