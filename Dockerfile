FROM ubuntu:20.04

RUN set -ex && \
    apt-get update && \
    apt-get install -y \
    python3 pip sudo

ARG DEBIAN_FRONTEND=noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN pip install meson conan
ARG CONAN_SYSREQUIRES_MODE=enabled
RUN conan profile new default --detect && \
    conan profile update settings.compiler.libcxx=libstdc++11 default

ENV HOME_DIR /home/develop

WORKDIR ${HOME_DIR}
RUN conan install -g pkg_config opencv/4.5.5@
