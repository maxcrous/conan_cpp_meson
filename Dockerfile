FROM ubuntu:20.04

RUN set -ex && \
    apt-get update && \
    apt-get install -y \
    python3 pip sudo git 

ARG DEBIAN_FRONTEND=noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN pip install meson conan ninja

# Makes conan install all system dependencies automatically 
ARG CONAN_SYSREQUIRES_MODE=enabled

# Makes conan enable C++11 library linking  
RUN conan profile new default --detect && \
    conan profile update settings.compiler.libcxx=libstdc++11 default


ENV HOME_DIR /home/develop
WORKDIR ${HOME_DIR}

# Install opencv through conan and store pkg-config files in local directory 
RUN conan install -g pkg_config opencv/4.5.5@
ARG PKG_CONFIG_PATH=${HOME_DIR}

# Use git to fetch the meson build script 
RUN git clone https://github.com/maxcrous/conan_cpp_meson.git

# Run the build commands
WORKDIR conan_cpp_meson
RUN meson build
RUN ninja -C build
