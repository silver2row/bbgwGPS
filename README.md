# bbgwGPS w/ gpsd!

I am using the BeagleBone Green Wireless with the Grove Connector at UART2

More info. about the board can be found here:
` https://wiki.seeedstudio.com/BeagleBone_Green_Wireless/ `

If you are not going to create the data logger like at the bottom section of this tutorial, please
use this bit of source after handling the restarting of the ` gpsd.service ` file!

```
#! /usr/bin/python3
"""
example  Python gpsd client
run this way: python3 example1.py.txt
"""

import gps               # the gpsd interface module

session = gps.gps(mode=gps.WATCH_ENABLE)

try:
    while 0 == session.read():
        if not (gps.MODE_SET & session.valid):
            # not useful, probably not a TPV message
            continue

        print('Mode: %s(%d) Time: ' %
              (("Invalid", "NO_FIX", "2D", "3D")[session.fix.mode],
               session.fix.mode), end="")
        # print time, if we have it
        if gps.TIME_SET & session.valid:
            print(session.fix.time, end="")
        else:
            print('n/a', end="")

        if ((gps.isfinite(session.fix.latitude) and
             gps.isfinite(session.fix.longitude))):
            print(" Lat %.6f Lon %.6f" %
                  (session.fix.latitude, session.fix.longitude))
        else:
            print(" Lat n/a Lon n/a")

except KeyboardInterrupt:
    # got a ^C.  Say bye, bye
    print('')

# Got ^C, or fell out of the loop.  Cleanup, and leave.
session.close()
exit(0)
```

That source can be found at https://gpsd.gitlab.io/gpsd/gpsd-client-example-code.html 

Yes sir!

...

Use python3 or ` chmod 0755 YourPython.py ` file and restart the gpsd.service file like so: ` sudo systemctl restart gpsd.service `
This way, the client is rebooted and can now be used w/ a simple ` ./YourPython.py `.

...

The kml wrapper in the GPS_data directory can be used as is in GoogleEarth for displaying
your location and your path taken.

Also, that other file, the .txt file in the GPS_data directory, will fill with your location
or past locations when you run the GPS.py file on your BeagleBone Green Wireless (WIP w/ gpsd)...

...

In theory, you can set up a .service file to run on boot so that the GPS.py file runs and 
follows you constantly. 

    I have a Grove Connector GPS device on the UART2 channel on the BBGW by BeagleBoard.org
    and Seeed-Studio. Once upon a time, the two of those entities came together to produce this 
    BBBW but w/ the Green heading for some reason. Although different, it works and it is a nice 
    board.

    The Grove GPS and BBGW are located in the files of photos. Enjoy...
...

Seth

P.S. That is all for now. Oh!

a file for ` /etc/systemd/system/GPS.service ` is found below for starting your service...

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

Oh and I learned those commands and about GPSBabel from this online community:

```
https://www.instructables.com/Raspberry-Pi-3-GPS-Data-Logger/
```

Logging!

If you need to go into specifics, go ahead or stick around for updates to this journey!
