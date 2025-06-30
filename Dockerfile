FROM ubuntu:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    apt-transport-https \
    ca-certificates \
    gnupg \
    curl \
    wget \
    git \
    python3 \
    python3-pip \
    fuse \
    yq \
    jq \
    unzip \
    htop \
    net-tools \
    dnsutils \
    inetutils-ping \
    telnet \
    tree \
    tmux \
    fzf  \
    vim  \
    tmux \
    ruby \
    golang \
    postgresql-client

# Basic vim setup
RUN git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
RUN sh ~/.vim_runtime/install_basic_vimrc.sh

# Install kubectl, Helm
# Add the Kubernetes apt repository key
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
# allow unprivileged APT programs to read this keyring
RUN chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg

RUN echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
# helps tools such as command-not-found to work correctly
RUN chmod 644 /etc/apt/sources.list.d/kubernetes.list
# Add the Helm apt repository key
RUN curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | tee /usr/share/keyrings/helm.gpg > /dev/null
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list

# Install kubectl, Helm
RUN apt-get update && apt-get install -y \
    kubectl \
    helm

RUN wget https://github.com/derailed/k9s/releases/latest/download/k9s_linux_arm64.deb \ 
    && apt install ./k9s_linux_arm64.deb \ 
    && rm k9s_linux_arm64.deb
    
# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
# Install Tailscale
RUN curl -fsSL https://tailscale.com/install.sh | sh

SHELL ["/bin/bash", "-c"]