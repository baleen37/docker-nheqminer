FROM nvidia/cuda:8.0-devel

ENV CUDA_CUDART_LIBRARY="/usr/local/cuda/lib64/libcudart.so"

RUN apt-get update -y -qq \
  && apt-get install -y -qq cmake libboost-all-dev git \
	&& git clone https://github.com/nicehash/nheqminer -b 0.5c \
	&& cd nheqminer/cpu_xenoncat/asm_linux \
            && chmod +x fasm \
            && sh assemble.sh \
            && cd / \
            && mkdir build/ \
            && cd build/ \
            && cmake -DCUDA_CUDART_LIBRARY=CUDA_CUDART_LIBRARY /nheqminer  \
            && make -j $(nproc)
	&& apt-get purge -y -qq cmake libboost-all-dev git
	&& rm /nheqminer

ENTRYPOINT ["/build/nheqminer"]

