#!/bin/bash


set -e

if [ -f /etc/configured ]; then
        echo 'already configured'
else
      #code that need to run only one time ....
        #needed for fix problem with ubuntu and cron
        echo "c.IPKernelApp.pylab = 'inline'" >>  /root/.jupyter/jupyter_notebook_config.py
        echo "c.NotebookApp.open_browser = False" >>  /root/.jupyter/jupyter_notebook_config.py
        echo "c.NotebookApp.ip = \"0.0.0.0\"" >>  /root/.jupyter/jupyter_notebook_config.py
        echo "c.NotebookApp.port = 8998" >>  /root/.jupyter/jupyter_notebook_config.py
        echo "c.NotebookApp.allow_origin = \"*\"" >>  /root/.jupyter/jupyter_notebook_config.py
        update-locale 
        date > /etc/configured
fi
