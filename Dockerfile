FROM nvidia/cudagl:10.2-devel-ubuntu18.04

RUN apt-get clean 
RUN apt-get update

RUN apt-get install -y --no-install-recommends apt-utils sudo 
RUN apt-get update && apt-get install -y --no-install-recommends \
    pkg-config \
    build-essential \
    cmake \
    git \
    curl \
    vim \
    wget\
    unzip\
    ca-certificates \
    gcc \
    g++ \
    gdb \
    x11-apps \
    meshlab \
    xvfb

# https://repo.anaconda.com/miniconda/Miniconda3-4.7.12.1-Linux-x86_64.sh
#   curl -sSL https://repo.continuum.io/miniconda/Miniconda3-4.3.11-Linux-x86_64.sh  -o /tmp/miniconda.sh \
#   
RUN apt-get -qq update && apt-get -qq -y install curl bzip2 \
    && curl -sSL https://repo.anaconda.com/miniconda/Miniconda3-4.7.12.1-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /opt/conda \
    && rm -rf /tmp/miniconda.sh 

ENV PATH="/opt/conda/bin:${PATH}"
RUN conda create -q -n dev python=3.6
SHELL ["conda", "run", "-n", "dev", "/bin/bash", "-c"]

WORKDIR / 
RUN conda install  pytorch==1.1.0 torchvision==0.3.0 cudatoolkit=10.0 -c pytorch 

RUN  conda install  -c conda-forge numpy opencv  matplotlib  tensorboard  scikit-image \
  && conda install  -c conda-forge cython  trimesh==3.6.18 pykdtree==1.3.1 \
  && conda install -c anaconda pandas=1.0.3

RUN conda install -y -c open3d-admin open3d  
RUN  pip install pymcubes==0.1.0  

