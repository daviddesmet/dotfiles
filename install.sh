export DEBIAN_FRONTEND=noninteractive
export INSTALL_ZSH=true
export USERNAME=`whoami`

# Update and install required packages
sudo apt-get update
sudo apt-get -y install --no-install-recommends apt-utils dialog 2>&1
sudo apt-get install -y \
  curl \
  git \
  gnupg2 \
  jq \
  sudo \
  openssh-client \
  less \
  iproute2 \
  procps \
  wget \
  unzip \
  apt-transport-https \
  lsb-release 

# Install Azure CLI
# echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | sudo tee -a /etc/apt/sources.list.d/azure-cli.list
# curl -sL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add - 2>/dev/null
# sudo apt-get update
# sudo apt-get install -y azure-cli;

# Install Jetbrains Mono font
wget https://download.jetbrains.com/fonts/JetBrainsMono-2.001.zip
sudo unzip JetBrainsMono-2.001.zip -d /usr/share/fonts
sudo fc-cache -f -v

# Install & Configure Zsh
if [ "$INSTALL_ZSH" = "true" ]
then
    sudo apt-get install -y \
    fonts-powerline \
    zsh

    # zsh
    # git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    # setopt EXTENDED_GLOB
    # for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    #     ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
    # done
    git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto
    ln -s ~/.zprezto/runcoms/zlogin ~/.zlogin
    ln -s ~/.zprezto/runcoms/zlogout ~/.zlogout
    ln -s ~/.zprezto/runcoms/zpreztorc ~/.zpreztorc
    ln -s ~/.zprezto/runcoms/zprofile ~/.zprofile
    ln -s ~/.zprezto/runcoms/zshenv ~/.zshenv
    
    cp -f ~/dotfiles/.dircolors ~/.dircolors
    cp -f ~/dotfiles/.p10k.zsh ~/.p10k.zsh
    cp -f ~/dotfiles/.vimrc ~/.vimrc
    cp -f ~/dotfiles/.zpreztorc ~/.zpreztorc
    cp -f ~/dotfiles/.zshrc ~/.zshrc
    chsh -s /usr/bin/zsh $USERNAME
fi

# Cleanup
sudo apt-get autoremove -y
sudo apt-get autoremove -y
sudo rm -rf /var/lib/apt/lists/*
