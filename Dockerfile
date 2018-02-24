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
    echo "/miner/bin/ethminer -U -S us2.ethermine.org:4444 -O $ETH_ADDRESS.$(hostname)" >> start.sh
    
ENTRYPOINT ["bash", "/miner/bin/start.sh"]
