docker-ijulia
=============

container running IJulia Notebook

docker run -d -p 8998:8998 quantumobject/docker-ijulia

run the after install script:

docker exec -it container_id /sbin/after_install

need to provide new password and info to generate ssl for access web interface of IJulia.


now you can check your IJulia at https://host_ip:8998/    


to access the container from server running docker :

docker exec -it container_id /bin/bash
