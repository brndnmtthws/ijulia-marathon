#!/bin/bash


set -e

if [ -f /etc/configured ]; then
        echo 'already configured'
else
      #code that need to run only one time ....
        #needed for fix problem with ubuntu and cron
        echo "c.IPKernelApp.pylab = 'inline'" >> /root/.ipython/profile_julia/ipython_notebook_config.py
        echo "c.NotebookApp.open_browser = False" >> /root/.ipython/profile_julia/ipython_notebook_config.py
        echo "c.NotebookApp.ip = \"*\"" >> /root/.ipython/profile_julia/ipython_notebook_config.py
        echo "c.NotebookApp.allow_origin = \"*\"" >> /root/.ipython/profile_julia/ipython_notebook_config.py
        update-locale 
        date > /etc/configured
fi
