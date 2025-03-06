# k8s tools
Docker image for debugging in k8s environments.

## tools
- unzip
- gnupg
- curl
- wget
- git
- python3
- python3-pip
- uv
- yq
- jq
- htop
- net-tools
- tree
- tmux
- fzf
- vim
- vimrc
- kubectl
- helm
- tailscale
- tmux
- ruby

## Usage
`kubectl run -i --tty --rm debug --image=base14/tools --restart=Never -- bash`
