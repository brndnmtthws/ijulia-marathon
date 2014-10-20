#!/bin/sh
### In tornado.sh (make sure this file is chmod +x):
# `/sbin/setuser xxxxx` runs the given command as the user `xxxxxx`.
# If you omit that part, the command will be run as root.

directory=/root/.juliabox/tornado

stdout_logfile_backups = 2
stdout_logfile_maxbytes = 1MB
stderr_logfile_backups = 2
stderr_logfile_maxbytes = 1MB


exec /root/.juliabox/tornado/src/fmanage.py >>/var/log/tornado.log 2>&1
