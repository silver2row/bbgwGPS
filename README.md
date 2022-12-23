# bbgwGPS w/ gpsd!

I am using the BeagleBone Green Wireless with the Grove Connector at UART2

...

Use python3 and restart the gpsd.service file like so: ` sudo systemctl restart gpsd.service `
This way, the client is rebooted and can now be used.

...

The kml wrapper in the GPS_data directory can be used as is in GoogleEarth for displaying
your location and your path taken.

Also, that other file, the .txt file in the GPS_data directory, will fill with your location
or past locations when you run the GPS.py file on your BeagleBone Green Wireless.

...

In theory, you can set up a .service file to run on boot so that the GPS.py file runs and 
follows you constantly. 

    I have a Grove Connector GPS device on the UART2 channel on the BBGW by BeagleBoard.org
    and Seeed-Studio. Once upon a time, the two of those entities came together to produce this 
    BBBW but w/ the Green heading for some reason. Although different, it works and it is a nice 
    board.

...

Seth

P.S. That is all for now. Oh!

```
[Unit]
Description=GPS .bash Script to Handle Movement

[Service]
ExecStartPre=/home/debian/config.sh
ExecStart=/home/debian/GPS.sh

[Install]
WantedBy=multi-user.target
```

and then... GPS.sh

```
#!/bin/bash

sudo gpsd /dev/ttyS2 -F /var/run/gpsd.sock

sleep 60

sudo gpspipe -r -d -l -o /home/debian/data/data.400.nmea
```

and then... config.sh

```
#!/bin/bash

config-pin p9.21 uart
config-pin p9.22 uart

sudo systemctl restart gpsd.service
```

Then...change /etc/default/gpsd

w/ the grove GPS for the BBGW, use ` /dev/ttyS2 `.

```
START_DAEMON="true"

DEVICES="/dev/ttyS2"
```

There will be more options, esp. when looking at gpsd, to pick from currently.

Enjoy!
