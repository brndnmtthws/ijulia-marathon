#!/bin/sh

mkdir -p /root/.ssl
openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout /root/.ssl/mycert.pem -out /root/.ssl/mycert.pem

echo "c.NotebookApp.certfile = u'/root/.ssl/mycert.pem'" >> /root/.ipython/profile_julia/ipython_notebook_config.py
