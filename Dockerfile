FROM nvidia/cudagl:10.2-devel-ubuntu18.04 

RUN apt update && apt install -y git \
  wget vim tar  libopenexr-dev \
  clang-9 libc++-9-dev libc++abi-9-dev cmake  \
  libz-dev libpng-dev libjpeg-dev libxrandr-dev libxinerama-dev libxcursor-dev \
  python3-dev python3-distutils python3-setuptools \
  python3-pytest python3-pytest-xdist python3-numpy \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENV CC=clang-9
ENV CXX=clang++-9
ENV CUDACXX=/usr/local/cuda/bin/nvcc

RUN mkdir /dev 
WORKDIR /dev
RUN wget https://ftp.nluug.nl/pub/graphics/blender/release/Blender2.91/blender-2.91.0-linux64.tar.xz
RUN tar -xf blender-2.91.0-linux64.tar.xz
RUN git clone git@github.com:DIYer22/bpycv.git  
RUN cd /dev/blender-2.91.0-linux64/2.91/python/bin

