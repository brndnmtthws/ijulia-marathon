#!/bin/bash


set -e

if [ -f /etc/configured ]; then
        ipython notebook --profile julia &
        echo 'already configured'
else
      #code that need to run only one time ....
        ipython notebook --profile julia &
        #needed for fix problem with ubuntu and cron
        update-locale 
        date > /etc/configured
fi
