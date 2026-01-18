# Path to the oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="gentoo"

# List of plugins to load
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# To disable escaping shell symbols when pasting URL from clipboard
# see https://github.com/ohmyzsh/ohmyzsh/issues/7632
DISABLE_MAGIC_FUNCTIONS=true

source $ZSH/oh-my-zsh.sh

# History,
# see http://zsh.sourceforge.net/Guide/zshguide02.html
# and https://linux.die.net/man/1/zshoptions
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt HIST_VERIFY
unsetopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
unsetopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS

# ----- fzf -----

source <(fzf --zsh)

# use fd instead of find to search in fzf

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/roose/.lmstudio/bin"
# End of LM Studio CLI section

