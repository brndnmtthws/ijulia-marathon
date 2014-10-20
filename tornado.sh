#!/bin/sh
### In tornado.sh (make sure this file is chmod +x):
# `/sbin/setuser xxxxx` runs the given command as the user `xxxxxx`.
# If you omit that part, the command will be run as root.

directory=/root/.juliabox/tornado

exec /root/.juliabox/tornado/src/fmanage.py >>/var/log/tornado.log 2>&1
