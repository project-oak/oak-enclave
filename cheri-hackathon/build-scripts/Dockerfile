FROM ubuntu:18.04
RUN apt-get update && \
    apt-get install -y \
        autoconf \
        libssl-dev \
        vim \
        nano \
        git \
        gdb \
        curl \
        wget \
        python \
        python3.6 \
        python3.6-dev \
        pkg-config \
        samba \
        libedit-dev \
        libarchive-dev \
        cmake \
        unzip \
        sudo \
        libglib2.0-dev \
        xz-utils \
        bison \
        flex \
        ninja-build \
        makefs \
        libpixman-1-dev \
        texinfo \
        gcc \
        g++ \
        libtool \
        && \
    # Installing Clang:
    wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    echo "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-8 main" > /etc/apt/sources.list.d/llvm.list && \
    apt-get update && \
    apt-get install -y clang-8 lld-8 && \
    # Creating a marker file to easily detect that we're inside docker container:
    touch /.dev-env

## Setting up user/group which matches the user on the host:
ARG USER=dev
ARG USER_ID
ARG USER_GID
RUN \
    groupadd --gid "${USER_GID}" "${USER}" && \
    useradd --uid ${USER_ID} --gid ${USER_GID} --create-home --shell /bin/bash ${USER} && \
    adduser ${USER} sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER ${USER}
ENV HOME=/home/${USER}
WORKDIR ${HOME}

## Add stuff here

WORKDIR ${HOME}/workdir
