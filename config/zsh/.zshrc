### zinit ###
declare -A ZINIT
ZINIT[HOME_DIR]="$XDG_DATA_HOME/zinit"
ZINIT[ZCOMPDUMP_PATH]="$XDG_STATE_HOME/zcompdump"
source "${ZINIT[HOME_DIR]}/bin/zinit.zsh"

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
# zinit light-mode for \
#     zdharma-continuum/zinit-annex-as-monitor \
#     zdharma-continuum/zinit-annex-bin-gem-node \
#     zdharma-continuum/zinit-annex-patch-dl \
#     zdharma-continuum/zinit-annex-rust

### path ###

export PATH="$DENO_INSTALL/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"

### plugin ###

zinit wait lucid blockf light-mode for \
  atload'async_init' mafredri/zsh-async \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-completions \
  zdharma-continuum/fast-syntax-highlighting

### fzf ###

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

### ls-colors ###

# alias ls='ls --color=auto'

# dircolors(LS_COLORS)
# これで上手くいくはずだが。。。
# lsコマンドのデフォルトのフォルダ色の青も出ていない。どこでおかしくなったか確認が必要か
# zinit ice atload'eval `dircolors $PWD/dircolors.ansi-universal`' as"null"
# zinit light seebi/dircolors-solarized

# ---------------------------------------------------------
# zsh fuzzy completion and utility plugin with Deno.
# yuki-yano/zeno.zsh(https://github.com/yuki-yano/zeno.zsh#user-configuration-file-example)
# ---------------------------------------------------------

__zeno_atload() {
  bindkey ' ' zeno-auto-snippet
  bindkey '^m' zeno-auto-snippet-and-accept-line
  bindkey '^i' zeno-completion
  bindkey '^r' zeno-history-selection
  # bindkey '^x' zeno-insert-snippet
  bindkey '^g' zeno-ghq-cd
}

export ZENO_HOME="$XDG_CONFIG_HOME/zeno"
zinit wait lucid light-mode for \
  atload'__zeno_atload' \
  @'yuki-yano/zeno.zsh'

export FZF_DEFAULT_OPTS='--reverse'

### asdf ###
export ASDF_DATA_DIR="$XDG_DATA_HOME/asdf"
export ASDF_CONFIG_FILE="$XDG_CONFIG_HOME/asdf/asdfrc"
source "${ASDF_DATA_DIR}/asdf.sh"

### starship ###
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}"/starship/starship.toml
zinit ice as"command" from"gh-r" atload'eval "$(starship init zsh)"'
zinit light starship/starship

### theme(lsd) ###

# export LS_COLORS="di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32"

alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

zinit ice as"command" from"gh-r" pick"lsd*/lsd"
zinit light lsd-rs/lsd

### keybind ###

# bash base key bind
bindkey \^U backward-kill-line

# zsh-shift-select https://stackoverflow.com/a/30899296
r-delregion() {
  if ((REGION_ACTIVE)) then
     zle kill-region
  else
    local widget_name=$1
    shift
    zle $widget_name -- $@
  fi
}
r-deselect() {
  ((REGION_ACTIVE = 0))
  local widget_name=$1
  shift
  zle $widget_name -- $@
}
r-select() {
  ((REGION_ACTIVE)) || zle set-mark-command
  local widget_name=$1
  shift
  zle $widget_name -- $@
}
for key     kcap   seq        mode   widget (
    sleft   kLFT   $'\e[1;2D' select   backward-char
    sright  kRIT   $'\e[1;2C' select   forward-char
    sup     kri    $'\e[1;2A' select   up-line-or-history
    sdown   kind   $'\e[1;2B' select   down-line-or-history
    send    kEND   $'\E[1;2F' select   end-of-line
    send2   x      $'\E[4;2~' select   end-of-line
    shome   kHOM   $'\E[1;2H' select   beginning-of-line
    shome2  x      $'\E[1;2~' select   beginning-of-line
    left    kcub1  $'\EOD'    deselect backward-char
    right   kcuf1  $'\EOC'    deselect forward-char
    end     kend   $'\EOF'    deselect end-of-line
    end2    x      $'\E4~'    deselect end-of-line
    home    khome  $'\EOH'    deselect beginning-of-line
    home2   x      $'\E1~'    deselect beginning-of-line
    csleft  x      $'\E[1;6D' select   backward-word
    csright x      $'\E[1;6C' select   forward-word
    csend   x      $'\E[1;6F' select   end-of-line
    cshome  x      $'\E[1;6H' select   beginning-of-line
    cleft   x      $'\E[1;5D' deselect backward-word
    cright  x      $'\E[1;5C' deselect forward-word
    del     kdch1   $'\E[3~'  delregion delete-char
    bs      x       $'^?'     delregion backward-delete-char
  ) {
  eval "key-$key() {
    r-$mode $widget \$@
  }"
  zle -N key-$key
  bindkey ${terminfo[$kcap]-$seq} key-$key
}
# Fix zsh-autosuggestions https://stackoverflow.com/a/30899296
export ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(
  key-right
)
# ctrl+x,c,v https://unix.stackexchange.com/a/634916/424080
function zle-clipboard-cut {
  if ((REGION_ACTIVE)); then
    zle copy-region-as-kill
    print -rn -- $CUTBUFFER | clip.exe
    zle kill-region
  fi
}
zle -N zle-clipboard-cut
function zle-clipboard-copy {
  if ((REGION_ACTIVE)); then
    zle copy-region-as-kill
    REGION_ACTIVE=0
    print -rn -- $CUTBUFFER | clip.exe
  else
    zle send-break
  fi
}
zle -N zle-clipboard-copy
function zle-clipboard-paste {
  if ((REGION_ACTIVE)); then
    zle kill-region
  fi
  LBUFFER+="$(cat clip.exe)"
}
zle -N zle-clipboard-paste
function zle-pre-cmd {
  stty intr "^@"
}
precmd_functions=("zle-pre-cmd" ${precmd_functions[@]})
function zle-pre-exec {
  stty intr "^C"
}
preexec_functions=("zle-pre-exec" ${preexec_functions[@]})
for key     kcap    seq           widget              arg (
    cx      _       $'^X'         zle-clipboard-cut   _
    cc      _       $'^C'         zle-clipboard-copy  _
    cv      _       $'^V'         zle-clipboard-paste _
) {
  if [ "${arg}" = "_" ]; then
    eval "key-$key() {
      zle $widget
    }"
  else
    eval "key-$key() {
      zle-$widget $arg \$@
    }"
  fi
  zle -N key-$key
  bindkey ${terminfo[$kcap]-$seq} key-$key
}
# ctrl+a https://stackoverflow.com/a/68987551/13658418
function widget::select-all() {
  local buflen=$(echo -n "$BUFFER" | wc -m | bc)
  CURSOR=$buflen  
  zle set-mark-command
  while [[ $CURSOR > 0 ]]; do
    zle beginning-of-line
  done
}
zle -N widget::select-all
zle_highlight=('paste:none')
