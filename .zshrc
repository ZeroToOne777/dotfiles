#
# zplug
#

source ~/.zplug/init.zsh

zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-syntax-highlighting', nice:10
zplug 'mollifier/anyframe'

if ! zplug check --verbose; then
  printf 'Install? [y/N]: '
  if read -q; then
    echo; zplug install
  fi
fi

zplug load --verbose

#
# Autoloadings
#

autoload -Uz add-zsh-hook
autoload -Uz compinit && compinit -u
autoload -Uz url-quote-magic
autoload -Uz vcs_info

#
# ZLE settings
#

zle -N self-insert url-quote-magic

#
# General settings
#

setopt auto_list
setopt auto_menu
setopt auto_pushd
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt ignore_eof
setopt inc_append_history
setopt interactive_comments
setopt no_beep
setopt no_hist_beep
setopt no_list_beep
setopt magic_equal_subst
setopt notify
setopt print_eight_bit
setopt print_exit_value
setopt prompt_subst
setopt pushd_ignore_dups
setopt rm_star_wait
setopt share_history
setopt transient_rprompt

#
# Exports
#

export CLICOLOR=true
export LSCOLORS='exfxcxdxbxGxDxabagacad'
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'
export EDITOR=vim
export HISTFILE=~/.zhistory
export HISTSIZE=1000
export SAVEHIST=1000000
export LANG=ja_JP.UTF-8

#
# Key bindings
#

bindkey -v
bindkey -v '^?' backward-delete-char
bindkey '^[[Z' reverse-menu-complete
bindkey '^@' anyframe-widget-cd-ghq-repository
bindkey '^r' anyframe-widget-put-history

#
# Aliases
#

alias vi='vim'

#
# Module settings
#

# Completion
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' use-cache true
zstyle ':completion:*' verbose yes
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:options' description 'yes'

#
# Prompt
#

POWERLINE_SEPARATOR=$'\ue0b2'
POWERLINE_SEPARATOR_LINE=$'\ue0b3'
POWERLINE_BRANCH=$'\ue0a0'

VI_MODE_INSERT='%F{4}%K{0}'$POWERLINE_SEPARATOR'%k%f%F{0}%K{4}%B INSERT %b%k%f'
VI_MODE_NORMAL='%F{2}%K{0}'$POWERLINE_SEPARATOR'%k%f%F{0}%K{2}%B NORMAL %b%k%f'

zstyle ':vcs_info:*' formats $POWERLINE_BRANCH' %b '$POWERLINE_SEPARATOR_LINE' '

function precmd_vi_mode() {
  VI_MODE=$VI_MODE_INSERT
}

function precmd_vcs_info() {
  vcs_info
}

function zle-keymap-select {
  case $KEYMAP in
    main|viins)
      VI_MODE=$VI_MODE_INSERT
      ;;
    vicmd)
      VI_MODE=$VI_MODE_NORMAL
      ;;
  esac
  zle reset-prompt
}

zle -N zle-keymap-select

add-zsh-hook precmd precmd_vi_mode
add-zsh-hook precmd precmd_vcs_info

PROMPT='%F{2}❯%f '
RPROMPT='%F{8}${vcs_info_msg_0_}%c%f ${VI_MODE}'

#
# Other settings
#

# rbenv

export PATH="$HOME/.rbenv/bin:$PATH"

eval "$(rbenv init - zsh)"
