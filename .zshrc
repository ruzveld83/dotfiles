# ----- oh-my-zsh config -----

# # Path to the oh-my-zsh installation.
# export ZSH="${HOME}/.oh-my-zsh"
#
# # Set name of the theme to load --- if set to "random", it will
# # load a random theme each time oh-my-zsh is loaded, in which case,
# # to know which specific one was loaded, run: echo $RANDOM_THEME
# # See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME=""
#
# # List of plugins to load
# # Standard plugins can be found in $ZSH/plugins/
# # Custom plugins may be added to $ZSH_CUSTOM/plugins/
# # Example format: plugins=(rails git textmate ruby lighthouse)
# # Add wisely, as too many plugins slow down shell startup.
# plugins=(git)
#
# # To disable escaping shell symbols when pasting URL from clipboard
# # see https://github.com/ohmyzsh/ohmyzsh/issues/7632
# DISABLE_MAGIC_FUNCTIONS=true
#
# source $ZSH/oh-my-zsh.sh

# ----- Zim -----
#
# This is a zsh framework that is simpler and faster than oh-my-zsh

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
ZIM_CONFIG_FILE=${HOME}/.config/zim/.zimrc
# Install missing modules and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
    source $(brew --prefix)/opt/zimfw/share/zimfw.zsh init
fi

# configure modules

zstyle ':zim:input' double-dot-expand yes # for making '...' into './..'

# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ----- History -----
#
# see http://zsh.sourceforge.net/Guide/zshguide02.html
# and https://linux.die.net/man/1/zshoptions

HISTSIZE=70000 # more than SAVEHIST in order to enable HIST_EXPIRE_DUPS_FIRST effect
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt HIST_VERIFY
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY_TIME
unsetopt INC_APPEND_HISTORY
unsetopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
unsetopt HIST_SAVE_NO_DUPS
unsetopt HIST_FIND_NO_DUPS

# ----- fzf -----

source <(fzf --zsh)

## use fd instead of find to search in fzf

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# ----- Aliases -----

alias lrd='l --tree --depth'
alias lr='lrd 2'

# ----- Misc -----

export LS_COLORS="$(vivid generate catppuccin-frappe)" # see https://github.com/sharkdp/vivid

## ghostty with shell-integrations enabled starts new tabs in cwd, this seems the like the only working solution to disable this while keeping the integrations enabled

if [[ "$TERMINAL_EMULATOR" != "JetBrains-JediTerm" ]]; then
  cd $HOME
fi

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_MANUAL_REBIND=1 # they say it makes it faster
WORDCHARS=${WORDCHARS/\//} # makes slash a word separator

if [[ "$TERMINAL_EMULATOR" == "JetBrains-JediTerm" ]]; then
  export STARSHIP_CONFIG=~/.config/starship/idea.toml
else
  export STARSHIP_CONFIG=~/.config/starship/main.toml
fi
