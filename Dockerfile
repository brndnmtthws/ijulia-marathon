#name of container: docker-ijulia-notebook
#versison of container: 0.5.1
FROM quantumobject/docker-baseimage
MAINTAINER Angel Rodriguez  "angel@quantumobject.com"

# Set correct environment variables.
ENV HOME /root

#add repository and update the container
#Installation of nesesary package/software for this containers...
RUN add-apt-repository ppa:staticfloat/julianightlies \
    && add-apt-repository ppa:staticfloat/julia-deps
RUN apt-get update && apt-get install -y -q apt-utils \
                    build-essential \
                    hdf5-tools \
                    glpk-utils \
                    libnlopt0 \
                    gfortran \
                    imagemagick \
                    inkscape \
                    gettext \
                    libreadline-dev \
                    libncurses-dev \
                    libpcre3-dev \
                    libgnutls28 \
                    tmux \
                    pkg-config \
                    pdf2svg \
                    libc6 \
                    libc6-dev \
                    python  \
                    python-dev  \
                    python-distribute \
                    python-software-properties \
                    software-properties-common \
                    python-setuptools \
                    python-yaml \
                    python-m2crypto \
                    python-crypto \
                    msgpack-python \
                    python-dev \
                    python-pip \
                    python-sympy \
                    python-zmq \
                    python-jinja2 \
                    python-requests \
                    python-numpy \
                    python-scipy \
                    python-matplotlib \
                    python-isodate \
                    pandoc \
                    libsundials-cvode1 \
                    libsundials-cvodes2 \
                    libsundials-ida2 \
                    libsundials-idas0 \
                    libsundials-kinsol1 \
                    libsundials-nvecserial0 \
                    libsundials-serial \
                    libsundials-serial-dev \
                    libnlopt-dev \
                    openmpi-bin \
                    libopenmpi-dev \
                    julia \
                    && apt-get clean \
                    && rm -rf /tmp/* /var/tmp/*  \
                    && rm -rf /var/lib/apt/lists/*
                    
# Ipopt
RUN mkdir ipopt; cd ipopt; wget  http://www.coin-or.org/download/source/Ipopt/Ipopt-3.11.7.tgz; \
    tar -xzf Ipopt-3.11.7.tgz; cd Ipopt-3.11.7; \
    cd ThirdParty/Blas; ./get.Blas; ./configure --prefix=/usr/local --disable-shared --with-pic; make install; cd ../..; \
    cd ThirdParty/Lapack; ./get.Lapack; ./configure --prefix=/usr/local --disable-shared --with-pic; make install; cd ../..; \
    cd ThirdParty/Mumps; ./get.Mumps; cd ../..; \
    ./configure --prefix=/usr/local --enable-dependency-linking --with-blas=/usr/local/lib/libcoinblas.a --with-lapack=/usr/local/lib/libcoinlapack.a; \
    make install; \
    echo "/usr/local/lib" > /etc/ld.so.conf.d/ipopt.conf; ldconfig; \
    cd ../..; \
    rm -rf ipopt

# Cbc
RUN mkdir cbc; cd cbc; wget http://www.coin-or.org/download/source/Cbc/Cbc-2.8.12.tgz; \
    tar -xzf Cbc-2.8.12.tgz; cd Cbc-2.8.12; \
    ./configure --prefix=/usr/local --enable-dependency-linking --without-blas --without-lapack --enable-cbc-parallel; \
    make install; \
    echo "/usr/local/lib" > /etc/ld.so.conf.d/cbc.conf; ldconfig; \
    cd ../..; \
    rm -rf cbc

RUN pip install "ipython[notebook]" --upgrade
#General variable definition....

##startup scripts  
#Pre-config scrip that maybe need to be run one time only when the container run the first time .. using a flag to don't 
#run it again ... use for conf for service ... when run the first time ...
RUN mkdir -p /etc/my_init.d
COPY startup.sh /etc/my_init.d/startup.sh
RUN chmod +x /etc/my_init.d/startup.sh


##Adding Deamons to containers

#pre-config scritp for different service that need to be run when container image is create 
#maybe include additional software that need to be installed ... with some service running ... like example mysqld
COPY pre-conf.sh /sbin/pre-conf
RUN chmod +x /sbin/pre-conf \
    && /bin/bash -c /sbin/pre-conf \
    && rm /sbin/pre-conf


##scritp that can be running from the outside using docker-bash tool ...
## for example to create backup for database with convitation of VOLUME   dockers-bash container_ID backup_mysql
COPY backup.sh /sbin/backup
RUN chmod +x /sbin/backup
VOLUME /var/backups


#add files and script that need to be use for this container
#include conf file relate to service/daemon 
#additionsl tools to be use internally 

# to allow access from outside of the container  to the container service
# at that ports need to allow access from firewall if need to access it outside of the server. 
EXPOSE 4200 8000 8998

#creatian of volume 
#VOLUME 

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
