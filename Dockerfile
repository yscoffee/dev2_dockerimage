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

RUN conda install -y python=3.6 numpy jupyter pip
RUN conda install -c conda-forge pybind11 opencv trimesh matplotlib  tensorboard scikit-image  jupyterlab  
RUN conda install -c open3d-admin open3d   
RUN pip install tensorboardX

WORKDIR /

#RUN conda install pytorch torchvision cudatoolkit=10.2 -c pytorch 
#RUN pip install torch-scatter==latest+cu102 -f https://pytorch-geometric.com/whl/torch-1.6.0.html
#RUN pip install torch-sparse==latest+cu102 -f https://pytorch-geometric.com/whl/torch-1.6.0.html
#RUN pip install torch-cluster==latest+cu102 -f https://pytorch-geometric.com/whl/torch-1.6.0.html
#RUN pip install torch-spline-conv==latest+cu102 -f https://pytorch-geometric.com/whl/torch-1.6.0.html
#RUN pip install torch-geometric








