FROM ubuntu:20.04

WORKDIR /opt/codal

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive TZ=Europe/London apt-get -y install tzdata && \
    apt install -y build-essential cmake git wget python3 python3-pip && \
    apt upgrade -y

RUN wget https://developer.arm.com/-/media/Files/downloads/gnu/11.2-2022.02/binrel/gcc-arm-11.2-2022.02-x86_64-arm-none-eabi.tar.xz && \
    tar xf gcc-arm-11.2-2022.02-x86_64-arm-none-eabi.tar.xz -C /usr/share/ && \
    ln -s /usr/share/gcc-arm-11.2-2022.02-x86_64-arm-none-eabi/bin/arm-none-eabi-gcc /usr/bin/arm-none-eabi-gcc && \
    ln -s /usr/share/gcc-arm-11.2-2022.02-x86_64-arm-none-eabi/bin/arm-none-eabi-g++ /usr/bin/arm-none-eabi-g++ && \
    ln -s /usr/share/gcc-arm-11.2-2022.02-x86_64-arm-none-eabi/bin/arm-none-eabi-gdb /usr/bin/arm-none-eabi-gdb && \
    ln -s /usr/share/gcc-arm-11.2-2022.02-x86_64-arm-none-eabi/bin/arm-none-eabi-size /usr/bin/arm-none-eabi-size && \
    ln -s /usr/share/gcc-arm-11.2-2022.02-x86_64-arm-none-eabi/bin/arm-none-eabi-objcopy /usr/bin/arm-none-eabi-objcopy && \
    ln -s /usr/lib/x86_64-linux-gnu/libncurses.so.6 /usr/lib/x86_64-linux-gnu/libncurses.so.5 && \
    ln -s /usr/lib/x86_64-linux-gnu/libtinfo.so.6 /usr/lib/x86_64-linux-gnu/libtinfo.so.5

RUN wget https://raw.githubusercontent.com/lancaster-university/codal-bootstrap/main/build.py
RUN python3 build.py codal-microbit-v2
COPY main.cpp /opt/codal/source/main.cpp
RUN python3 build.py

ENTRYPOINT ["/bin/bash"]