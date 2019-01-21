# Filename:      /etc/zsh/zshrc
# PATH=.zshrc
# Purpose:       config file for zsh (z shell)
# Author:        moi

# History - Relics of the past.
HISTFILE=~/.config/zsh.d/history
HISTSIZE=1000
SAVEHIST=1000

# add to fpath
fpath=(~/.config/zsh.d $fpath)

# vim bindings
# bindkey -v

# Variables
export PATH="${HOME}/.cargo/bin:${HOME}/.local/bin:/opt/texlive/2018/bin/x86_64-linux:${PATH}:${GOPATH}/bin"

export BROWSER="firefox"
export EDITOR="vim"
export SUDO_EDITOR="rvim"
export PASSWORD_STORE_CLIP_TIME=5
export WINEDEBUG=-all
# export GOROOT="/usr/lib/go"
# export GOPATH="${HOME}/go"
# export RUST_SRC_PATH="$( rustc --print sysroot )/lib/rustlib/src/rust/src"


# Colours for ls
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

# Keybindings
bindkey -e
typeset -g -A key
bindkey '^?' backward-delete-char
bindkey '^[[5~' up-line-or-history
bindkey '^[[3~' delete-char
bindkey '^[[6~' down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[D' backward-char
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char 
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# Shell options
setopt autocd \
       hist_verify \
       hist_append \
       hist_save_no_dups \
       hist_ignore_space \
       hist_ignore_all_dups

# Aliases (or Alii)
alias ra="ranger"
alias ls="ls --color -F --group-directories-first"
alias ll="ls --color -lh --group-directories-first"
alias rm="rm -vI"
alias cp="cp -vi"
alias mv="mv -vi"
alias mkdir="mkdir -pv"
alias syslog="socklog"

alias rebuild="make clean all && sudo make install"

alias xq="xbps-query -Rs"
alias xu="sudo xbps-install -Su"
alias mkdoc="sudo makewhatis /usr/share/man"

alias 'gcm '="git commit -m "
alias gp="git push"

alias cdf="ssh singhk39@teach.cs.utoronto.ca"
alias porn="mpv 'https://www.pornhub.com/random'"

# Modules
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' rehash yes
zstyle ':completion:*' list-colors

# Prompt
autoload -U colors zsh/terminfo
colors
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats "%{${fg[cyan]}%}[%{${fg[green]}%}%s%{${fg[cyan]}%}][%{${fg[blue]}%}%r/%S%%{${fg[cyan]}%}][%{${fg[blue]}%}%b%{${fg[yellow]}%}%m%u%c%{${fg[cyan]}%}]%{$reset_color%}"

# setprompt() {
#   setopt prompt_subst
# 
#   if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then 
#     p_host='%F{yellow}%M%f'
#   else
#     p_host='%F{blue}%M%f'
#   fi
# 
#   PS1=${(j::Q)${(Z:Cn:):-$'
#     %F{cyan}[%f
#     %(!.%F{red}%n%f.%F{blue}%n%f)
#     %F{cyan}@%f
#     ${p_host}
#     %F{cyan}][%f
#     %F{blue}%~%f
#     %F{cyan}]%f
#     %(!.%F{red}%#%f.%F{magenta}%#%f)
#     " "
#   '}}
# 
#   PS2=$'%_>'
#   RPROMPT=$'${vcs_info_msg_0_}'
# }
# setprompt

setprompt() {
  setopt prompt_subst

  if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then 
    p_host='%F{yellow}%M%f'
  else
    p_host='%F{blue}%M%f'
  fi

  PS1=${(j::Q)${(Z:Cn:):-$'
    %F{blue}%~%f
    " "
    %(!.%F{blue}%#%f.%F{blue}%#%f)
    " "
  '}}

  PS2=$'%_>'
  RPROMPT=$'${vcs_info_msg_0_}'
}
setprompt

# Fixes for the suckless simple terminal
if [[ $TERM = st-* ]]
then
  function zle-line-init () { echoti smkx }
  function zle-line-finish () { echoti rmkx }
  zle -N zle-line-init
  zle -N zle-line-finish
else
  function zle-line-init () { }
  function zle-line-finish () { }
fi

# acempv function
acempv () {
  if [[ -n $1 ]]
  then
    mpv --cache-secs=60 "http://127.0.0.1:8000/pid/$1/stream.mp4"
  else
    echo "acempv: No argument given"
  fi
}

# smloadr function
smloadr () {
  if [ -x /home/kartik/Music/smloadr ]
  then
    DIR=${PWD}
    cd /home/kartik/Music/smloadr
    ./SMLoadr-linux-x64 $1
    cd ${DIR}
  else
    echo "File doesn't exist: ~/Music/smloadr/SMLoadr-linux-x64"
  fi
}

# twitch wrapper with streamlink, mpv function
twitch () {
  if [[ -n $1 ]]
  then
    if [[ -n $2 ]]
    then
      streamlink -p mpv "https://twitch.tv/${1}" ${2}
    else
      streamlink -p mpv "https://twitch.tv/${1}" best
    fi
  else
    echo "USAGE: twitch channel_name [quality]"
  fi
}

# Music sync function
musicsync () {

  help () {
    echo "USAGE: musicsync [-d] [<phone_ip>]"
  }

  local PHONEIP=""
  local DELETE=""
  for arg in "$@"
  do
    case $arg in
      -h|--help)
        help
        return 1
        ;;
      -d|--delete)
        local DELETE="--delete"
        ;;
      *)
        if [ ! -z ${PHONEIP} ]
        then
          help
          return 0
        fi
        PHONEIP="${arg}"
        ;;
    esac
  done

  if [ -z ${PHONEIP} ]
  then
    PHONEIP="192.168.100.127"
  fi

  rsync -r --size-only --verbose --progress --ignore-existing -e 'ssh -p 8022'\
    ${DELETE} ~/Music/synced_music/\
    ${PHONEIP}:/sdcard/Music/synced_music
}

PATH="/home/kartik/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/kartik/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/kartik/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/kartik/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/kartik/perl5"; export PERL_MM_OPT;
