FROM ubuntu:18.04
WORKDIR /data
RUN apt-get update && \
    apt-get install --no-install-recommends -yq \
    apt-transport-https \
    arping \
    arptables \
    bridge-utils \
    ca-certificates \
    conntrack \
    curl \
    dirmngr  \
    dnsutils \
    ethtool \
    gdb \
    iperf \
    iperf3 \
    iproute2 \
    ipsec-tools \
    ipset \
    iptables \
    iputils-ping \
    jq \
    kmod \
    ldap-utils \
    less \
    libpcap-dev \
    lsb-release \
    net-tools \
    netcat \
    netcat-openbsd \
    npm \
    openssl \
    psmisc \
    python-dbg \
    python3-dbg \
    socat \
    software-properties-common \
    strace \
    tcpdump \
    telnet \
    tmux \
    tree \
    unzip \
    vim \
    git htop redis-tools mysql-client-5.7 kafkacat \
    wget \ 
    zsh

# Configure Timezone
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata && \
    rm -rf /var/lib/apt/lists/*

RUN ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# Install node 16
RUN curl -o- https://deb.nodesource.com/setup_16.x | bash
RUN apt -y install nodejs

# Install docker
# RUN curl -sL https://download.docker.com/linux/static/stable/x86_64/docker-18.06.1-ce.tgz > docker.tgz && \
#     tar xzf docker.tgz docker && \
#     mv docker /usr/bin/docker && \
#     chmod +x /usr/bin/docker && \
#     rm -rf docker.tgz

# Install NVM and YARN
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
RUN npm install -g yarn

# Install k8s
# RUN curl -sL https://storage.googleapis.com/kubernetes-release/release/v1.9.10/bin/linux/amd64/kubectl > /usr/local/bin/kubectl-1.9 && \
#     curl -sL https://storage.googleapis.com/kubernetes-release/release/v1.10.5/bin/linux/amd64/kubectl > /usr/local/bin/kubectl-1.10 && \
#     curl -sL https://storage.googleapis.com/kubernetes-release/release/v1.11.2/bin/linux/amd64/kubectl > /usr/local/bin/kubectl-1.11 && \
#     curl -sL https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/linux/amd64/kubectl > /usr/local/bin/kubectl-1.13 && \
#     chmod +x /usr/local/bin/kubectl* && \
#     ln -s /usr/local/bin/kubectl-1.13 /usr/local/bin/kubectl && \
#     mkdir /root/.kube


# RUN echo "deb [trusted=yes] https://repo.iovisor.org/apt/bionic bionic-nightly main" | tee /etc/apt/sources.list.d/iovisor.list && \
#     apt-get update && \
#     apt-get install -y --allow-unauthenticated bcc-tools && \
#     rm -rf /var/lib/apt/lists/*

# Install AWS Cli
RUN curl -sL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip && \
    rm -dfr aws

RUN cd ~/ && \
    mkdir work

# ENV TZ=America/Sao_Paulo

CMD ["python3","-m", "http.server" ,"80"]
