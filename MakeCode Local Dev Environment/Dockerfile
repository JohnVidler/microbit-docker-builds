FROM ubuntu:20.04

ENV PXT_FORCE_LOCAL=1
#ENV PXT_RUNTIME_DEV=1
#ENV PXT_ASMDEBUG=1
#ENV PXT_DEBUG=1
ENV PXT_NODOCKER=1
#ENV PXT_COMPILE_SWITCHES=csv---mbcodal

WORKDIR /opt/pxt

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive TZ=Europe/London apt-get -y install tzdata && \
    apt install -y build-essential cmake software-properties-common nodejs npm git wget libncurses-dev && \
    apt upgrade -y && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt update && \
    apt install -y python3.6 python3-pip python-setuptools ninja-build python-dev libffi-dev libssl-dev && \
    pip install yotta

RUN wget https://developer.arm.com/-/media/Files/downloads/gnu/11.2-2022.02/binrel/gcc-arm-11.2-2022.02-x86_64-arm-none-eabi.tar.xz && \
    tar xf gcc-arm-11.2-2022.02-x86_64-arm-none-eabi.tar.xz -C /usr/share/ && \
    ln -s /usr/share/gcc-arm-11.2-2022.02-x86_64-arm-none-eabi/bin/arm-none-eabi-gcc /usr/bin/arm-none-eabi-gcc && \
    ln -s /usr/share/gcc-arm-11.2-2022.02-x86_64-arm-none-eabi/bin/arm-none-eabi-g++ /usr/bin/arm-none-eabi-g++ && \
    ln -s /usr/share/gcc-arm-11.2-2022.02-x86_64-arm-none-eabi/bin/arm-none-eabi-gdb /usr/bin/arm-none-eabi-gdb && \
    ln -s /usr/share/gcc-arm-11.2-2022.02-x86_64-arm-none-eabi/bin/arm-none-eabi-size /usr/bin/arm-none-eabi-size && \
    ln -s /usr/share/gcc-arm-11.2-2022.02-x86_64-arm-none-eabi/bin/arm-none-eabi-objcopy /usr/bin/arm-none-eabi-objcopy && \
    ln -s /usr/lib/x86_64-linux-gnu/libncurses.so.6 /usr/lib/x86_64-linux-gnu/libncurses.so.5 && \
    ln -s /usr/lib/x86_64-linux-gnu/libtinfo.so.6 /usr/lib/x86_64-linux-gnu/libtinfo.so.5

RUN cd /opt/pxt && \
    git clone -b v7.5.29 https://github.com/microsoft/pxt pxt && \
    cd /opt/pxt/pxt && \
    npm install && \
    npm run build

RUN cd /opt/pxt && \
    git clone -b v9.5.7 https://github.com/microsoft/pxt-common-packages pxt-common-packages && \
    cd /opt/pxt/pxt-common-packages && \
    npm install && \
    npm install pxt -g

RUN cd /opt/pxt && \
    git clone -b v4.1.32 https://github.com/microsoft/pxt-microbit pxt-microbit && \
    cd /opt/pxt/pxt-microbit
COPY pxtarget.json /opt/pxt/pxt-microbit/pxtarget.json

RUN cd /opt/pxt/pxt-microbit && \
    pxt link /opt/pxt/pxt && \
    pxt link /opt/pxt/pxt-common-packages && \
    npm install && \
    pxt buildtarget --local

CMD [ "pxt", "serve" ]