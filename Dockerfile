FROM nvidia/cuda:9.1-devel-ubuntu16.04
WORKDIR /

ENV ETH_ADDRESS=0x8D06b549CD7B4Fd4966D927202E5C3F64AE9c25f
ENV GPU_FORCE_64BIT_PTR=0
ENV GPU_MAX_HEAP_SIZE=100
ENV GPU_USE_SYNC_OBJECTS=1
ENV GPU_MAX_ALLOC_PERCENT=100
ENV GPU_SINGLE_ALLOC_PERCENT=100

RUN apt-get update && apt-get -y install software-properties-common wget

RUN mkdir /miner && \
    cd /miner && \
    wget https://github.com/ethereum-mining/ethminer/releases/download/v0.14.0.dev2/ethminer-0.14.0.dev2-Linux.tar.gz && \
    tar -xvf ethminer-0.14.0.dev2-Linux.tar.gz
    
RUN cd bin/ && \
    touch /miner/bin/start.sh && \
    echo "/miner/bin/ethminer --farm-recheck 200 -G -S eu1.ethermine.org:4444 -FS us1.ethermine.org:4444 -O $ETH_ADDRESS.$(hostname)" >> start.sh
    
ENTRYPOINT ["bash", "/miner/bin/start.sh"]
