# Filename:      /etc/zsh/zshrc
# Purpose:       config file for zsh (z shell)
# Author:        moi

# History - Relics of the past.
HISTFILE=~/.config/zsh.d/.zshhist
HISTSIZE=1000
SAVEHIST=1000

# add to fpath
fpath=(~/.config/zsh.d $fpath)

# vim bindings
# bindkey -v

# Variables
export PATH="${HOME}/.cargo/bin:${HOME}/.local/bin:/opt/texlive/2018/bin/x86_64-linux:${PATH}:${GOPATH}/bin"

export BROWSER="qutebrowser"
export EDITOR="vim"
export PASSWORD_STORE_CLIP_TIME=5
export GOROOT="/usr/lib/go"
export GOPATH="${HOME}/go"
export RUST_SRC_PATH="$( rustc --print sysroot )/lib/rustlib/src/rust/src"


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
alias ls="ls --color -F --group-directories-first"
alias ll="ls --color -lh --group-directories-first"
alias rm="rm -vI"
alias cp="cp -vi"
alias mv="mv -vi"
alias mkdir="mkdir -pv"
alias bt=bluetoothctl
alias rebuild="make clean all && sudo make install"
alias xq="xbps-query -Rs"
alias xu="sudo xbps-install -Su"
alias dlna="minidlnad -f /home/$USER/.config/minidlna/minidlna.conf -P /home/$USER/.config/minidlna/minidlna.pid"

alias gcm="git commit -m"
alias gp="git push"

alias porn="mpv 'https://www.pornhub.com/random'"
alias rockradio="mpv 'http://dir.xiph.org/listen/1771713/listen.m3u'"
alias classicalradio="mpv 'http://dir.xiph.org/listen/1191247/listen.m3u'"

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

# Delete key suckless terminal
function zle-line-init () { echoti smkx }
function zle-line-finish () { echoti rmkx }
zle -N zle-line-init
zle -N zle-line-finish

# Music sync function
alias music2phone="rsync -r --size-only --verbose --progress --ignore-existing -e 'ssh -p 8022' ~/music/synced_music/ 192.168.42.129:/sdcard/Music/synced_music"

PATH="/home/kartik/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/kartik/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/kartik/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/kartik/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/kartik/perl5"; export PERL_MM_OPT;
