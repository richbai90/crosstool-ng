FROM debian:bullseye-20220711-slim
RUN apt-get update && apt-get -y install apt-utils \
    git automake make bison chrpath flex curl \
    g++ git gperf gawk help2man \
    libexpat1-dev libncurses5-dev \
    libsdl1.2-dev libtool libtool-bin \
    libtool-doc python2.7-dev texinfo unzip \
    && git clone https://github.com/crosstool-ng/crosstool-ng.git \
    && cd crosstool-ng || exit 1 \
    && git checkout "$(git describe --tags --abbrev=0)" \
    && ./bootstrap \
    && ./configure \
    && make \
    && make install \
    && cd .. || exit 1 \
    && rm -rf crosstool-ng \
    && useradd -m ng

    USER ng
    WORKDIR /home/ng
    RUN mkdir -p /home/ng/src /home/ng/x-tools
    CMD ct-ng list-samples