# Path to the oh-my-zsh installation.
export ZSH="/Users/ruslan.izmailov/.oh-my-zsh"

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

export CLOUD_CLIENT_HOME=/Users/ruslan.izmailov/Projects/odkl-zeppelin
export PATH="/usr/local/opt/ant@1.9/bin:/usr/local/sbin:$(brew --prefix python)/libexec/bin:$PATH"
