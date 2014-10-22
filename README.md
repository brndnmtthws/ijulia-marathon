docker-ijulia
=============

container running IJulia Notebook

docker run -d -p 8888:8888 quantumobject/docker-ijulia

run the after install script to increase security :

docker exec -it container_id /sbin/after_install


now you can check your ijulia at https://host:8888/    if after_install was not run then check http://...


to access the container from server running docker :

docker exec -it container_id /bin/bash


NO ready to be use ... future work to be done...
