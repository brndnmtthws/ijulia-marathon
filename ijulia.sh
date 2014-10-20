#!/bin/sh
### In ijulia.sh (make sure this file is chmod +x):
# `/sbin/setuser xxxxx` runs the given command as the user `xxxxxx`.
# If you omit that part, the command will be run as root.


exec ipython notebook --no-browser --no-secure --profile julia >>/var/log/ijulia.log 2>&1
