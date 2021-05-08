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

ENV PATH="/usr/local/cuda/bin/:/opt/conda/bin:${PATH}"
ENV export TORCH_CUDA_ARCH_LIST="6.1;7.0;7.5"

RUN conda install -y python=3.8 numpy jupyter pip
RUN conda install -c conda-forge pybind11 opencv trimesh matplotlib  tensorboard scikit-image notebook  
RUN conda install -c open3d-admin open3d   
RUN conda install pytorch==1.8.0 torchvision==0.9.0 torchaudio==0.8.0 -c pytorch

RUN pip install torch-points-kernels==0.6.6
RUN pip install torch-points3d


WORKDIR /


