FROM andreasfertig/cppinsights-docker-base:latest

LABEL maintainer "Andreas Fertig"

ENV CLANG_VERSION=${CLANG_VERSION}
ENV GCC_VERSION=${GCC_VERSION}

ARG DEBIAN_FRONTEND=noninteractive

# Install compiler, python
RUN apt-get update && \
    apt-get install -y --no-install-recommends ninja-build git llvm-${CLANG_VERSION}-dev g++-${GCC_VERSION} libpolly-${CLANG_VERSION}-dev lcov cmake zlib1g-dev doxygen graphviz curl && \
    rm -rf /var/lib/apt/lists/*

RUN useradd builder \
    && mkdir /home/builder \
    && chown -R builder:builder /home/builder

RUN ln -s /usr/bin/llvm-config-${CLANG_VERSION} /usr/bin/llvm-config
RUN ln -fs /usr/bin/g++-${GCC_VERSION} /usr/bin/g++
RUN ln -fs /usr/bin/g++-${GCC_VERSION} /usr/bin/c++
RUN ln -fs /usr/bin/gcc-${GCC_VERSION} /usr/bin/gcc
RUN ln -fs /usr/bin/gcc-${GCC_VERSION} /usr/bin/cc
RUN ln -fs /usr/bin/python3 /usr/bin/python
RUN ln -fs /usr/bin/gcov-${GCC_VERSION} /usr/bin/gcov
