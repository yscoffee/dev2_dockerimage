
FROM nvidia/cudagl:9.2-devel-ubuntu18.04

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
    gdb 

RUN apt-get update && apt-get install -y  --no-install-recommends \
    libboost-all-dev \
    libsuitesparse-dev \ 
    libgoogle-glog-dev \ 
    libatlas-base-dev\ 
    zlib1g-dev \
    libjpeg-dev \
    libpng-dev  

# libigl
RUN apt-get update && apt-get install -y libxi-dev libxmu-dev libxinerama-dev libxcursor-dev libxrandr-dev mesa-common-dev libgl1-mesa-dev libglu1-mesa-dev libx11-dev 

RUN apt-get install -y  --no-install-recommends \
    mesa-utils x11-apps \
    libassimp-dev assimp-utils 

RUN apt-get -qq update && apt-get -qq -y install curl bzip2 \
    && curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /opt/conda \
    && rm -rf /tmp/miniconda.sh 

ENV PATH="/opt/conda/bin:${PATH}"

RUN conda install -y python=3.6 numpy jupyter pip
RUN conda install -c conda-forge xtl xtensor xtensor-io  
RUN conda install -c conda-forge xtensor-python pybind11
RUN conda install -c conda-forge opencv trimesh matplotlib  tensorboard scikit-image
RUN conda install -c omnia eigen3==3.3.7  
RUN conda install -c open3d-admin open3d  
RUN conda install pytorch==1.0.1 torchvision==0.2.2 cudatoolkit=9.0 -c pytorch 

WORKDIR /tmp

RUN mkdir /thirdparts
WORKDIR /thirdparts

RUN apt-get install -y --no-install-recommends \
    libglew-dev  \
    libgl1-mesa-dev  

RUN git clone --depth=1 https://github.com/stevenlovegrove/Pangolin.git && \
    cd Pangolin && \
    mkdir build && \
    cd build && \
    cmake .. -DEIGEN_INCLUDE_DIR=/opt/conda/include/eigen3 && \
    cmake --build . && \
    make install

RUN git clone --depth=1 https://github.com/jlblancoc/nanoflann.git && \ 
    cd nanoflann && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j 10 && \
    make install
    


RUN git clone --depth=1 https://github.com/CLIUtils/CLI11.git && \
    cd CLI11 && \
    git submodule update --init && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j 10 && \
    make install

RUN mkdir /usr/include/mpark/ && \ 
    cp /thirdparts/Pangolin/include/mpark/variant.hpp /usr/include/mpark/  
    
    
    
