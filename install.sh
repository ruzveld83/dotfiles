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
)

script_path=$(readlink -f "$0")
dotfiles_repo=$(dirname "$script_path")
echo "Dotfiles repo path: ${dotfiles_repo}"

# Directory to backup existing dotfiles
backup_dir="$HOME/dotfiles-backup"

install_oh_my_zsh() {
    echo "Going to install Oh My Zsh"
    if [ "${dry_run}" = false ]; then
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
            if [ "${dry_run}" = false ]; then
                mv "$HOME/$file" "$backup_dir"
            fi
            echo "Moved ${HOME}/${file} to ${backup_dir}" 
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

declare dry_run
if [ -n "$1" ] && [ "$1" = "--dry-run" ]; then
    dry_run=true
    echo "Dry run mode enabled. No commands will be executed"
else
    dry_run=false
fi

install_oh_my_zsh
backup_dotfiles
create_symlinks

echo "Dotfiles installation complete!"
