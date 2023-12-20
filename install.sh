#!/bin/bash
set -euo pipefail

# Set the names of dotfiles you want to manage
dotfiles=(
".gitconfig"
".gitignore"
".ideavimrc"
".profile"
".zprofile"
".config/nvim"
".zshrc"
)

script_path=$(readlink -f "$0")
dotfiles_repo=$(dirname "$script_path")
echo "Dotfiles repo path: ${dotfiles_repo}"

# Directory to backup existing dotfiles
backup_dir="$HOME/dotfiles-backup"

install_brew() {
    echo "Going to install brew"
    if [ "${dry_run}" = false ] && [ ! -f "/opt/homebrew/bin/brew" ]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
}

install_oh_my_zsh() {
    echo "Going to install Oh My Zsh"
    if [ "${dry_run}" = false ] && [ -z ${ZSH} ]; then
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
}

backup_dotfiles() {
    echo "Going to backup dotfiles"
    if [ "${dry_run}" = false ]; then
        mkdir -p "$backup_dir"
    fi
    for file in "${dotfiles[@]}"; do
        if [ -f "${HOME}/${file}" ] || [ -d "${HOME}/${file}" ]; then
            if [ -h "${HOME}/${file}" ]; then
                if [ "${dry_run}" = false ]; then
                    rm -r "${HOME}/${file}"
                fi
                echo "Removed symlink ${HOME}/${file}"
            else
                if [ "${dry_run}" = false ]; then
                    mv "$HOME/$file" "$backup_dir"
                fi
                echo "Moved ${HOME}/${file} to ${backup_dir}"
            fi
        fi
    done
}

create_symlinks() {
    echo "Going to create symlinks"
    for file in "${dotfiles[@]}"; do
        if [ "${dry_run}" = false ]; then
            ln -s "${dotfiles_repo}/${file}" "${HOME}/${file}"
        fi
        echo "symlinked ${HOME}/${file} to ${dotfiles_repo}/${file}"
    done
}

install_fonts() {
    echo "Going to install fonts"
    if [ "${dry_run}" = false ]; then
        brew tap homebrew/cask-fonts
        brew install font-ubuntu-mono-nerd-font
    fi
}

setup_iterm() {
    echo "Going to install and configure iterm"
    if [ "${dry_run}" = false ]; then
        brew tap homebrew/cask-versions
        brew install iterm2-beta
        defaults write com.googlecode.iterm2 PrefsCustomFolder -string "${HOME}/dotfiles/iterm"
        defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
    fi
}

install_java() {
    echo "Going to install java"
    if [ "${dry_run}" = false ]; then
        brew tap homebrew/cask-versions
        brew install zulu8 openjdk@11 openjdk@17 openjdk@21
        sudo ln -sfn /opt/homebrew/opt/openjdk@11/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-11.jdk
        sudo ln -sfn /opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-17.jdk
        sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
    fi
}

install_misc() {
    echo "Going to install misc apps"
    if [ "${dry_run}" = false ]; then
        brew install sublime-text rectangle scroll-reverser alfred nvim
    fi
}

declare dry_run
if [ "$#" -gt 0 ] && [ "${1}" = "--dry-run" ]; then
    dry_run=true
    echo "Dry run mode enabled. No commands will be executed"
else
    dry_run=false
fi

install_brew
install_oh_my_zsh
backup_dotfiles
create_symlinks
install_fonts
setup_iterm
install_java
install_misc

echo "Dotfiles installation complete!"
