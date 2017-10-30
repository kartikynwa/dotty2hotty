#
# PATH=.zshrc
#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
autoload zmv
export EDITOR=nvim
alias vim=nvim
alias porn="mpv 'https://www.pornhub.com/random'"

# Export PATH
export PATH=~/.local/bin:$PATH