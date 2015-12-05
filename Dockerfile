FROM ubuntu:15.04

ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH
ENV SHELL /bin/bash

COPY pre-conf.sh /sbin/pre-conf

RUN apt-get install -yfq software-properties-common && \
  add-apt-repository ppa:staticfloat/julianightlies && \
  add-apt-repository ppa:staticfloat/julia-deps && \
  apt-get update && apt-get install -y -q --no-install-recommends apt-utils \
                    wget \
                    git \
                    build-essential \
                    bzip2 \
                    unzip \
                    python3 \
                    python3-dev  \
                    ca-certificates \
                    libsm6 \
                    pandoc \
                    texlive-latex-base \
                    texlive-latex-extra \
                    texlive-fonts-extra \
                    texlive-fonts-recommended \
                    libxrender1 \
                    gfortran \
                    gcc \
                    fonts-dejavu \
                    libnettle4 \
                    julia \
                    libpng12-dev \
                    libglib2.0-dev \
                    librsvg2-dev \
                    libpixman-1-dev \
                    hdf5-tools \
                    glpk-utils \
                    libnlopt0 \
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
                    python3-zmq \
                    python3-jinja2 \
                    python3-requests \
                    python3-numpy \
                    python3-isodate \
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
                    libopenmpi-dev && \
  apt-get clean && \
  rm -rf /tmp/* /var/tmp/* && \
  rm -rf /var/lib/apt/lists/* && \
  mkdir -p $CONDA_DIR && \
  echo export PATH=$CONDA_DIR/bin:'$PATH' > /etc/profile.d/conda.sh && \
  wget --quiet https://repo.continuum.io/miniconda/Miniconda3-3.9.1-Linux-x86_64.sh && \
  echo "6c6b44acdd0bc4229377ee10d52c8ac6160c336d9cdd669db7371aa9344e1ac3 *Miniconda3-3.9.1-Linux-x86_64.sh" | sha256sum -c - && \
  /bin/bash /Miniconda3-3.9.1-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
  rm Miniconda3-3.9.1-Linux-x86_64.sh && \
  $CONDA_DIR/bin/conda install --yes conda==3.14.1 && \
  conda install --yes \
    'notebook=4.0*' \
    terminado \
    && conda clean -yt && \
  conda install --yes \
    'ipywidgets=4.0*' \
    'pandas=0.16*' \
    'matplotlib=1.4*' \
    'scipy=0.15*' \
    'seaborn=0.6*' \
    'scikit-learn=0.16*' \
    'scikit-image=0.11*' \
    'sympy=0.7*' \
    'cython=0.22*' \
    'patsy=0.3*' \
    'statsmodels=0.6*' \
    'cloudpickle=0.1*' \
    'dill=0.2*' \
    'numba=0.20*' \
    'bokeh=0.9*' \
    && conda clean -yt && \
  ln -s /opt/conda/pkgs/zeromq-4.0.*/lib/libzmq.so.4.* /opt/conda/lib/libzmq.so.4 && \
  ln -s /opt/conda/pkgs/libsodium-0.4.*/lib/libsodium.so.4.* /opt/conda/lib/libsodium.so.4 && \
  mkdir ipopt; cd ipopt; wget --quiet http://www.coin-or.org/download/source/Ipopt/Ipopt-3.12.4.tgz; \
    tar -xzf Ipopt-3.12.4.tgz; cd Ipopt-3.12.4; \
    cd ThirdParty/Blas; ./get.Blas; ./configure --prefix=/usr/local --disable-shared --with-pic; make install; cd ../..; \
    cd ThirdParty/Lapack; ./get.Lapack; ./configure --prefix=/usr/local --disable-shared --with-pic; make install; cd ../..; \
    cd ThirdParty/Mumps; ./get.Mumps; cd ../..; \
    ./configure --prefix=/usr/local --enable-dependency-linking --with-blas=/usr/local/lib/libcoinblas.a --with-lapack=/usr/local/lib/libcoinlapack.a; \
    make install; \
    echo "/usr/local/lib" > /etc/ld.so.conf.d/ipopt.conf; ldconfig; \
    cd ../..; \
    rm -rf ipopt && \
  mkdir cbc; cd cbc; wget --quiet http://www.coin-or.org/download/source/Cbc/Cbc-2.9.7.tgz; \
    tar -xzf Cbc-2.9.7.tgz; cd Cbc-2.9.7; \
    ./configure --prefix=/usr/local --enable-dependency-linking --without-blas --without-lapack --enable-cbc-parallel; \
    make install; \
    echo "/usr/local/lib" > /etc/ld.so.conf.d/cbc.conf; ldconfig; \
    cd ../..; \
    rm -rf cbc && \
  /bin/bash -c /sbin/pre-conf \
    && rm /sbin/pre-conf

COPY run-ijulia-notebook /usr/bin/run-ijulia-notebook
