#
# Executes commands at the start of an interactive session.
#

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Applies workaround for color support of ls on dirs that are other-writable (o+x) and not sticky, making them readable
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Functions
glog() {
  setterm -linewrap off

  git --no-pager log --all --color=always --graph --abbrev-commit --decorate \
      --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' | \
      sed -E \
          -e 's/\|(\x1b\[[0-9;]*m)+\\(\x1b\[[0-9;]*m)+ /├\1─╮\2/' \
          -e 's/(\x1b\[[0-9;]+m)\|\x1b\[m\1\/\x1b\[m /\1├─╯\x1b\[m/' \
          -e 's/\|(\x1b\[[0-9;]*m)+\\(\x1b\[[0-9;]*m)+/├\1╮\2/' \
          -e 's/(\x1b\[[0-9;]+m)\|\x1b\[m\1\/\x1b\[m/\1├╯\x1b\[m/' \
          -e 's/╮(\x1b\[[0-9;]*m)+\\/╮\1╰╮/' \
          -e 's/╯(\x1b\[[0-9;]*m)+\//╯\1╭╯/' \
          -e 's/(\||\\)\x1b\[m   (\x1b\[[0-9;]*m)/╰╮\2/' \
          -e 's/(\x1b\[[0-9;]*m)\\/\1╮/g' \
          -e 's/(\x1b\[[0-9;]*m)\//\1╯/g' \
          -e 's/^\*|(\x1b\[m )\*/\1⎬/g' \
          -e 's/(\x1b\[[0-9;]*m)\|/\1│/g' \
          | command less -r +'/[^/]HEAD'

  setterm -linewrap on
}

#find() {
#  if [ $# = 1 ];
#  then
#    command find . -iname "*$@*"
#  else
#    command find "$@"
#  fi
#}

# Fun stuff
if [ -f /usr/local/bin/neofetch ]; then neofetch; fi

# Node Version Manager
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
