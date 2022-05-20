FROM ubuntu:20.04

ENV PXT_FORCE_LOCAL=1
#ENV PXT_RUNTIME_DEV=1
#ENV PXT_ASMDEBUG=1
#ENV PXT_DEBUG=1
ENV PXT_NODOCKER=1
#ENV PXT_COMPILE_SWITCHES=csv---mbcodal

# Update and upgrade the system, installing python 3.6 explicitly for yotta
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive TZ=Europe/London apt-get -y install tzdata && \
    apt install -y build-essential cmake software-properties-common nodejs npm git wget srecord libncurses-dev && \
    apt upgrade -y && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt update && \
    apt install -y python3.6 python3-pip python-setuptools ninja-build python-dev libffi-dev libssl-dev

# Actually install yotta
WORKDIR /home
COPY requirements.txt /home/requirements.txt
RUN python3 -m pip --no-cache-dir install --upgrade pip && \
    python3 -m pip --no-cache-dir install -r /home/requirements.txt && \
    rm /home/requirements.txt


# Download and install the arm toolchain (arm-non-eabi-*)
WORKDIR /opt/
RUN cd /opt/ && \
    wget -q https://developer.arm.com/-/media/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2 && \
    echo "8312c4c91799885f222f663fc81f9a31  gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2" >> MD5SUM && \
    md5sum -c MD5SUM && \
    rm MD5SUM && \
    tar -xf gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2 && \
    rm gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2
ENV PATH $PATH:/opt/gcc-arm-none-eabi-10-2020-q4-major/bin

# Grab PXT and build
WORKDIR /opt/pxt
RUN cd /opt/pxt && \
    git clone -b v7.5.29 https://github.com/microsoft/pxt pxt && \
    cd /opt/pxt/pxt && \
    npm install && \
    npm run build

# Grab pxt-common-packages and build
RUN cd /opt/pxt && \
    git clone -b v9.5.7 https://github.com/microsoft/pxt-common-packages pxt-common-packages && \
    cd /opt/pxt/pxt-common-packages && \
    npm install && \
    npm install pxt -g

# Grab pxt-microbit and copy our modified config for yotta over
RUN cd /opt/pxt && \
    git clone -b v4.1.32 https://github.com/microsoft/pxt-microbit pxt-microbit && \
    cd /opt/pxt/pxt-microbit
COPY pxtarget.json /opt/pxt/pxt-microbit/pxtarget.json

# Link pxt and pxt-common-packages, then build pxt-microbit
RUN cd /opt/pxt/pxt-microbit && \
    npm link /opt/pxt/pxt && \
    npm link /opt/pxt/pxt-common-packages && \
    cd /opt/pxt/pxt && \
    npm install gulp -g && \
    gulp && \
    cd /opt/pxt/pxt-microbit && \
    npm install && \
    pxt buildtarget --local

# Serve as a local service
CMD [ "pxt", "serve" ]