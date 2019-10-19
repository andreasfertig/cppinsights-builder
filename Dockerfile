FROM andreasfertig/cppinsights-docker-base:latest

LABEL maintainer "Andreas Fertig"

ENV CLANG_VERSION=${CLANG_VERSION}
ENV GCC_VERSION=${GCC_VERSION}

# Install compiler, python
RUN apt-get update && \
    apt-get install -y --no-install-recommends ninja-build git llvm-${CLANG_VERSION}-dev g++-${GCC_VERSION} cmake zlib1g-dev doxygen graphviz python2.7 && \
    rm -rf /var/lib/apt/lists/*

RUN useradd builder \
    && mkdir /home/builder \
    && chown -R builder:builder /home/builder

RUN ln -s /usr/bin/llvm-config-${CLANG_VERSION} /usr/bin/llvm-config

RUN ln -fs /usr/bin/g++-${GCC_VERSION} /usr/bin/g++
RUN ln -fs /usr/bin/g++-${GCC_VERSION} /usr/bin/c++
RUN ln -fs /usr/bin/gcc-${GCC_VERSION} /usr/bin/gcc
RUN ln -fs /usr/bin/gcc-${GCC_VERSION} /usr/bin/cc
RUN ln -fs /usr/bin/python2.7 /usr/bin/python

# We need this for now to build a more recent version of lcov
RUN apt-get update &&                                                          \
    apt-get install -y --no-install-recommends wget build-essential unzip libperlio-gzip-perl libjson-perl &&   \
    cd /tmp &&                                                                 \
    wget https://github.com/linux-test-project/lcov/archive/master.zip &&      \
    unzip master.zip &&                                                        \
    cd lcov-master &&                                                          \
    make install &&                                                            \
    cd / &&                                                                    \
    rm -rf /tmp/* &&                                                           \
    apt-get remove --purge -y wget unzip cpp-7 dpkg-dev g++-7 gcc-7 libdpkg-perl make patch xz-utils && \
    ln -fs /usr/bin/g++-${GCC_VERSION} /usr/bin/g++ && \
    ln -fs /usr/bin/g++-${GCC_VERSION} /usr/bin/c++ && \
    ln -fs /usr/bin/gcc-${GCC_VERSION} /usr/bin/gcc && \
    ln -fs /usr/bin/gcc-${GCC_VERSION} /usr/bin/cc && \
    rm -rf /var/lib/apt/lists/* &&                                             \
    ln -fs /usr/bin/gcov-${GCC_VERSION} /usr/bin/gcov
