# Use ubuntu as base image
FROM ubuntu:latest

# Ensure debconf does not show interactive installer                   
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install system packages
RUN set -ex && \
    apt-get update && \
    apt-get install -y \
    python3 pip sudo git 

# Install python packages
RUN pip install meson conan ninja

# Makes conan install non-library dependencies (system dependencies) automatically as well
ARG CONAN_SYSREQUIRES_MODE=enabled

# Configures conan to use the C++11 standard library implementation.
# Without this, some libraries like OpenCV do not compile.
RUN conan profile new default --detect && \
    conan profile update settings.compiler.libcxx=libstdc++11 default

# Set working directory 
ENV HOME_DIR /home/develop
WORKDIR ${HOME_DIR}

# Install C++ libraries through conan. Use pkg_config generator to produce .pc files.
RUN conan install -g pkg_config opencv/4.5.5@

# Set the the pkg_config .pc files search path to the current directory.
ARG PKG_CONFIG_PATH=${HOME_DIR}

# Use git to fetch the meson build script 
RUN git clone https://github.com/maxcrous/conan_cpp_meson.git

# Run the build commands
WORKDIR conan_cpp_meson
RUN meson build
RUN ninja -C build
