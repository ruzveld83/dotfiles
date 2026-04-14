[ -f ~/.profile-local ] && source ~/.profile-local
[ -f ~/.profile-specific ] && source ~/.profile-specific

export LANG=en_US.UTF-8

function jdk() {
        version=$1
        export JAVA_HOME=$(/usr/libexec/java_home -v"$version");
        if [ "$2" != "silent" ]
        then
                java -version
        fi
}

jdk 21 silent

# usage: compress_videos "*.mp4"
alias compress_videos='~/scripts/compress_videos.sh'

alias flush-dns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'

export M2_HOME=/usr/local/Cellar/maven/3.8.2/libexec
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$(go env GOPATH)/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:/opt/homebrew/opt/ant@1.9/bin:/usr/local/sbin:$(brew --prefix python)/libexec/bin:$(brew --prefix ruby)/bin:$PATH"
export PATH="$PATH:/Users/roose/.lmstudio/bin"

alias tmux-01-doc-rag="~/.config/tmux/sessions/01-doc-rag.sh"
alias tmux-dotfiles="~/.config/tmux/sessions/dotfiles.sh"
alias tmux-project="~/.config/tmux/sessions/project.sh"
