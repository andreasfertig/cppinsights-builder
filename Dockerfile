FROM andreasfertig/cppinsights-docker-base:latest

LABEL maintainer "Andreas Fertig"

# Install compiler, python
RUN apt-get update && \
    apt-get install -y --no-install-recommends ninja-build git llvm-${CLANG_VERSION}-dev g++-8 cmake zlib1g-dev doxygen graphviz && \
    rm -rf /var/lib/apt/lists/*

RUN useradd builder \
    && mkdir /home/builder \
    && chown -R builder:builder /home/builder

RUN ln -s /usr/bin/llvm-config-${CLANG_VERSION} /usr/bin/llvm-config

RUN ln -fs /usr/bin/g++-8 /usr/bin/g++
RUN ln -fs /usr/bin/g++-8 /usr/bin/c++
RUN ln -fs /usr/bin/gcc-8 /usr/bin/gcc
RUN ln -fs /usr/bin/gcc-8 /usr/bin/cc
