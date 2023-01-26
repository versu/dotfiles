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

### theme
zinit ice pick"async.zsh" src"pure.zsh" # with zsh-async library that's bundled with it.
zinit light sindresorhus/pure

# customize style (https://github.com/sindresorhus/pure#:~:text=%E2%89%A1-,Zstyle%20options,-Showing%20git%20stash)
zstyle :prompt:pure:git:branch color yellow
zstyle :prompt:pure:path color cyan

### plugin ###

zinit wait lucid blockf light-mode for \
  atload'async_init' mafredri/zsh-async \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-completions \
  zdharma-continuum/fast-syntax-highlighting

### fzf ###

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

### ls-colors ###

alias ls='ls --color=auto'

# dircolors(LS_COLORS)
# これで上手くいくはずだが。。。
# lsコマンドのデフォルトのフォルダ色の青も出ていない。どこでおかしくなったか確認が必要か
zinit ice atload'eval `dircolors $PWD/dircolors.ansi-universal`' as"null"
zinit light seebi/dircolors-solarized

# ---------------------------------------------------------
# zsh fuzzy completion and utility plugin with Deno.
# yuki-yano/zeno.zsh(https://github.com/yuki-yano/zeno.zsh#user-configuration-file-example)
# ---------------------------------------------------------

__zeno_atload() {
  bindkey ' ' zeno-auto-snippet
  bindkey '^m' zeno-auto-snippet-and-accept-line
  bindkey '^i' zeno-completion
  bindkey '^r' zeno-history-selection
  bindkey '^x' zeno-insert-snippet
  bindkey '^g' zeno-ghq-cd
}

export ZENO_HOME="$XDG_CONFIG_HOME/zeno"
zinit wait lucid light-mode for \
  atload'__zeno_atload' \
  @'yuki-yano/zeno.zsh'

export FZF_DEFAULT_OPTS='--reverse'
