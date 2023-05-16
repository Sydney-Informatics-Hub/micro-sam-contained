
# Build with:
# sudo docker build . -t sydneyinformaticshub/micro-sam

# Run with e.g.:
# xhost +
# sudo docker run --gpus all --device /dev/dri/ -it --rm  -e DISPLAY=unix$DISPLAY  -v ~/DATA/:/project -v /tmp/.X11-unix:/tmp/.X11-unix  -e QT_X11_NO_MITSHM=1  sydneyinformaticshub/micro-sam
# micro_sam.annotator_2d -i /project/test.jpeg

# Pull base image.
FROM nvidia/cuda:11.7.0-devel-ubuntu18.04
MAINTAINER Nathaniel Butterworth USYD SIH

# Set up ubuntu dependencies
RUN apt-get update -y && \
  apt-get install -y wget git build-essential git curl libgl1 libglib2.0-0 libsm6 libxrender1 libxext6 && \
  rm -rf /var/lib/apt/lists/*

# Make the dir everything will go in
WORKDIR /build

# Intall anaconda
ENV PATH="/build/miniconda3/bin:${PATH}"
ARG PATH="/build/miniconda3/bin:${PATH}"
RUN curl -o miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-py38_4.12.0-Linux-x86_64.sh &&\
	mkdir /build/.conda && \
	bash miniconda.sh -b -p /build/miniconda3 &&\
	rm -rf miniconda.sh

RUN conda --version

RUN conda install mamba -n base -c conda-forge
RUN mamba install napari python-elf pytorch pytorch-cuda>=11.7 torchvision tqdm pip -c pytorch -c nvidia -c conda-forge
RUN pip install git+https://github.com/facebookresearch/segment-anything.git

RUN git clone https://github.com/computational-cell-analytics/micro-sam && cd micro-sam \
  && pip install -e .

RUN conda clean -a -y
RUN pip cache purge

RUN mkdir /project /scratch && touch /usr/bin/nvidia-smi

CMD /bin/bash
#

