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

# May need to set this to install all required conan packages, check
# RUN conan config set general.revisions_enabled=1

# Set working directory 
ENV HOME_DIR /home/develop
WORKDIR ${HOME_DIR}

#RUN git clone https://github.com/maxcrous/conan_cpp_meson.git
ADD . /home/develop/conan_cpp_meson
 
# Install C++ libraries through conan. Use pkg_config generator to produce .pc files.
#RUN conan install -g pkg_config opencv/4.5.5@
#RUN conan install -g pkg_config imgui/1.87@

WORKDIR conan_cpp_meson
RUN conan install conanfile.txt

# Replace the " with \" in the imgui pkg-config file (imgui.pc) 
# Otherwise pkg-config misinterprets the " in the compiler option -DIMGUI_USER_CONFIG="imgui_user_config.h"
RUN sed -i 's/\"imgui_user_config.h\"/\\"imgui_user_config.h\\"/' imgui.pc

# Conan placed all pc files in the current directory, so use it as path for pkg-config
ENV PKG_CONFIG_PATH /home/develop/conan_cpp_meson
RUN meson build
RUN ninja -C build 
