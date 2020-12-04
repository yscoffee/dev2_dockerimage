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
    x11-apps 


RUN apt-get -qq update && apt-get -qq -y install curl bzip2 \
    && curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /opt/conda \
    && rm -rf /tmp/miniconda.sh 

ENV PATH="/opt/conda/bin:${PATH}"
WORKDIR /

RUN conda create -n dev python=3.6
RUN conda activate dev && conda install pytorch==1.1.0 torchvision==0.3.0 cudatoolkit=10.0 -c pytorch
RUN conda activate dev && conda install -c conda-forge numpy opencv trimesh matplotlib  tensorboard scikit-image
RUN conda activate dev && conda install -c open3d-admin open3d
RUN conda activate dev && conda install cython==0.29.15  trimesh==3.6.18 pykdtree==1.3.1 pandas==1.0.3 
RUN conda activate dev && pip install pymcubes==0.1.0

