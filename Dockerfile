FROM ubuntu:22.04

# Update apt software source (for China mainland):
RUN sed -i s:/archive.ubuntu.com:/mirrors.tuna.tsinghua.edu.cn/ubuntu:g /etc/apt/sources.list \
    && apt-get clean \
    && apt-get -y update --fix-missing

# Prerequisites:
RUN apt-get install -y ca-certificates \
    && apt-get install -y build-essential gdb git libreadline-dev libsdl2-dev llvm-11 llvm-11-dev \
    && ln -s /usr/bin/llvm-config-11 /usr/bin/llvm-config \
    && apt-get install -y g++-riscv64-linux-gnu binutils-riscv64-linux-gnu openjdk-17-jdk wget \
    && apt-get install -y help2man perl python3 make autoconf g++ flex bison ccache libgoogle-perftools-dev numactl perl-doc libfl2 libfl-dev zlib1g zlib1g-dev \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y gtkwave \
    && apt-get clean

# Verilator
RUN cd ~ \
    && git clone https://github.com/verilator/verilator \
    && unset VERILATOR_ROOT \
    && cd verilator && git pull && git checkout v5.008 \
    && autoconf \
    && ./configure \
    && make -j `nproc` \
    && make install \
    && cd ~ && rm -rf ./verilator

# Clone ysyx-workbench
RUN cd ~ \
    && git clone -b master https://github.com/OSCPU/ysyx-workbench.git \
    && cd ysyx-workbench \
    && sed -i s!git@github.com:!https://github.com/!g init.sh \
    && bash init.sh nemu \
    && bash init.sh abstract-machine \
    && bash init.sh am-kernels \
    && bash init.sh nanos-lite \
    && bash init.sh navy-apps \
    && bash init.sh nvboard \
    && cd ~/ysyx-workbench/navy-apps/apps/pal/ \
    && wget https://box.nju.edu.cn/f/73c08ca0a5164a94aaba/\?dl\=1 -O pal-data-new.tar.bz2