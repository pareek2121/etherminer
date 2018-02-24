FROM nvidia/cuda:9.1-devel-ubuntu16.04
WORKDIR /

ENV ETH_ADDRESS=

RUN apt-get update && apt-get -y install software-properties-common wget

RUN mkdir /miner && \
    cd /miner && \
    wget https://github.com/ethereum-mining/ethminer/releases/download/v0.14.0.dev2/ethminer-0.14.0.dev2-Linux.tar.gz && \
    tar -xvf ethminer-0.14.0.dev2-Linux.tar.gz
    
RUN cd bin/ && \
    touch /miner/bin/start.sh && \
    echo "
    export GPU_FORCE_64BIT_PTR=0
    export GPU_MAX_HEAP_SIZE=100
    export GPU_USE_SYNC_OBJECTS=1
    export GPU_MAX_ALLOC_PERCENT=100
    export GPU_SINGLE_ALLOC_PERCENT=100
    bin/ethminer --farm-recheck 200 -G -S eu1.ethermine.org:4444 -FS us1.ethermine.org:4444 -O 0x9ef9c1b6e4395df8EEc59E7C9cdC9F126B6b9876.$1
    " >> start.sh
    
ENTRYPOINT ["bash", "/miner/bin/start.sh"]
