# docker build -t pytorch:1.8.2-cuda11.1-python3.6-full .
# docker run --gpus all -it pytorch:1.8.2-cuda11.1-python3.6-full
# Use the nvidia/cuda:11.1-devel-ubuntu18.04 as the base image
FROM nvidia/cuda:11.1.1-devel-ubuntu18.04

# Set environment variables for Python 3.6
ENV PYTHON_VERSION=3.6

# Install Python 3.6 and other dependencies
RUN apt-get update && apt-get install -y \
    python3.6 \
    python3.6-dev \
    python3.6-venv \
    python3-pip \
    build-essential \
    cmake \
    git \
    curl \
    libopenblas-dev \
    libomp-dev \
    sudo wget \
    zip unzip tar \
    nano vim \
    ffmpeg libsm6 libxext6 \
    && rm -rf /var/lib/apt/lists/*

# Create a symlink for python3
RUN ln -sf /usr/bin/python3.6 /usr/bin/python3
RUN ln -sf /usr/bin/python3.6 /usr/bin/python

# Upgrade pip
RUN python3 -m pip install --upgrade pip

# Install PyTorch 1.8.2 with CUDA 11.1 support
RUN pip install torch==1.8.2 torchvision==0.9.2 torchaudio==0.8.2 --extra-index-url https://download.pytorch.org/whl/lts/1.8/cu111

# Install additional packages
RUN pip install \
    absl-py==1.4.0 \
    appdirs==1.4.4 \
    asttokens==2.4.1 \
    certifi==2024.6.2 \
    charset-normalizer==2.0.12 \
    click==8.0.4 \
    cloudpickle==1.3.0 \
    colorama==0.4.5 \
    configparser==5.2.0 \
    cycler==0.11.0 \
    dataclasses==0.8 \
    docker-pycreds==0.4.0 \
    einops==0.4.1 \
    executing==2.0.1 \
    future==1.0.0 \
    gitdb==4.0.9 \
    GitPython==3.1.18 \
    gym==0.17.2 \
    icecream==2.1.3 \
    idna==3.7 \
    imageio==2.15.0 \
    importlib-metadata==4.8.3 \
    kiwisolver==1.3.1 \
    matplotlib==3.3.4 \
    numpy==1.19.5 \
    opencv-python==4.2.0.34 \
    packaging==21.3 \
    pathtools==0.1.2 \
    Pillow==8.4.0 \
    promise==2.3 \
    protobuf==3.12.4 \
    psutil==6.0.0 \
    pyastar2d==1.0.2 \
    pyglet==1.5.0 \
    Pygments==2.14.0 \
    pyparsing==3.1.2 \
    python-dateutil==2.9.0.post0 \
    PyYAML==6.0.1 \
    requests==2.27.1 \
    scipy==1.5.4 \
    sentry-sdk==2.7.1 \
    setproctitle==1.2.3 \
    setuptools==59.6.0 \
    shortuuid==1.0.13 \
    six==1.16.0 \
    smmap==5.0.0 \
    subprocess32==3.5.4 \
    tensorboardX==2.0 \
    typing_extensions==4.1.1 \
    urllib3==1.26.19 \
    wandb==0.10.5 \
    watchdog==2.3.1 \
    wheel==0.37.1 \
    zipp==3.6.0

# Set the working directory
WORKDIR /workspace

# Default command
CMD ["/bin/bash"]
