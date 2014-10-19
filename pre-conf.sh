#!/bin/bash


#reason of this script is that dockerfile only execute one command at the time but we need sometimes at the moment we create 
#the docker image to run more that one software for expecified configuration like when you need mysql running to chnage or create
#database for the container ...

julia -e 'Pkg.add("IJulia")'

#to make sure don't return with error from installing IJulia
echo 'done pre-configuration'
