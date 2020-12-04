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

RUN wget https://raw.githubusercontent.com/yscoffee/dev2_dockerimage/ifnet/env.yml  && conda env create -f env.yml && conda activate dev 






