#name of container: docker-ijulia-notebook
#versison of container: 0.5.5
FROM quantumobject/docker-baseimage:15.04
MAINTAINER Angel Rodriguez  "angel@quantumobject.com"

#add repository and update the container
#Installation of nesesary package/software for this containers...
RUN add-apt-repository ppa:staticfloat/julianightlies \
    && add-apt-repository ppa:staticfloat/julia-deps 
RUN apt-get update && apt-get install -y -q --no-install-recommends apt-utils \
                    build-essential \
                    bzip2 \
                    unzip \
                    libnettle4 \
                    libpng12-dev \
                    libglib2.0-dev \
                    librsvg2-dev \
                    libpixman-1-dev \
                    hdf5-tools \
                    glpk-utils \
                    libnlopt0 \
                    gfortran \
                    gcc \
                     fonts-dejavu \
                     libxrender1 \
                    imagemagick \
                    inkscape \
                    gettext \
                    libreadline-dev \
                    libncurses-dev \
                    libpcre3-dev \
                    libgnutls28-dev \
                    tmux \
                    pkg-config \
                    pdf2svg \
                    libc6 \
                    libc6-dev \
                    python3 \
                    python3-dev  \
                    python-distribute \
                    python3-software-properties \
                    software-properties-common \
                    python3-setuptools \
                    python3-yaml \
                    python-m2crypto \
                    python-poppler \
                    python3-crypto \
                    python3-msgpack \
                    libffi-dev \
                    libssl-dev \
                    libzmq3-dev \
                    python3-pip \
                    python-sympy \
                    python3-zmq \
                    python3-jinja2 \
                    python3-requests \
                    python3-numpy \
                    python3-scipy \
                    python3-matplotlib \
                    python3-isodate \
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
                    texlive-latex-base \
                    texlive-latex-extra \
                    texlive-fonts-extra \
                    texlive-fonts-recommended \
                    julia \
                    && apt-get clean \
                    && rm -rf /tmp/* /var/tmp/*  \
                    && rm -rf /var/lib/apt/lists/*
                    
# ipython notebook install
RUN apt-get update  && pip3 install jupyter ipywidgets ipython\
                    && apt-get clean \
                    && rm -rf /tmp/* /var/tmp/*  \
                    && rm -rf /var/lib/apt/lists/*
                   
# Ipopt
RUN mkdir ipopt; cd ipopt; wget  http://www.coin-or.org/download/source/Ipopt/Ipopt-3.12.4.tgz; \
    tar -xzf Ipopt-3.12.4.tgz; cd Ipopt-3.12.4; \
    cd ThirdParty/Blas; ./get.Blas; ./configure --prefix=/usr/local --disable-shared --with-pic; make install; cd ../..; \
    cd ThirdParty/Lapack; ./get.Lapack; ./configure --prefix=/usr/local --disable-shared --with-pic; make install; cd ../..; \
    cd ThirdParty/Mumps; ./get.Mumps; cd ../..; \
    ./configure --prefix=/usr/local --enable-dependency-linking --with-blas=/usr/local/lib/libcoinblas.a --with-lapack=/usr/local/lib/libcoinlapack.a; \
    make install; \
    echo "/usr/local/lib" > /etc/ld.so.conf.d/ipopt.conf; ldconfig; \
    cd ../..; \
    rm -rf ipopt

# Cbc
RUN mkdir cbc; cd cbc; wget http://www.coin-or.org/download/source/Cbc/Cbc-2.9.7.tgz; \
    tar -xzf Cbc-2.9.7.tgz; cd Cbc-2.9.7; \
    ./configure --prefix=/usr/local --enable-dependency-linking --without-blas --without-lapack --enable-cbc-parallel; \
    make install; \
    echo "/usr/local/lib" > /etc/ld.so.conf.d/cbc.conf; ldconfig; \
    cd ../..; \
    rm -rf cbc
    
##startup scripts  
#Pre-config scrip that maybe need to be run one time only when the container run the first time .. using a flag to don't 
#run it again ... use for conf for service ... when run the first time ...
RUN mkdir -p /etc/my_init.d
COPY startup.sh /etc/my_init.d/startup.sh
RUN chmod +x /etc/my_init.d/startup.sh

##Adding Deamons to containers
RUN mkdir /etc/service/ijulia
COPY ijulia.sh /etc/service/ijulia/run
RUN chmod +x /etc/service/ijulia/run

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
COPY after_install.sh /sbin/after_install
RUN chmod +x /sbin/after_install

# to allow access from outside of the container  to the container service
# at that ports need to allow access from firewall if need to access it outside of the server. 
EXPOSE 8998

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
