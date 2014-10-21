#!/bin/sh
### In ijulia.sh (make sure this file is chmod +x):
# `/sbin/setuser xxxxx` runs the given command as the user `xxxxxx`.
# If you omit that part, the command will be run as root.


exec julia -e "using IJulia;notebook();" >>/var/log/ijulia.log 2>&1
