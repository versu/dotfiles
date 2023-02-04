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
zinit light Peltoche/lsd

