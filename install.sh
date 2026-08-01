#!/usr/bin/env bash
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🔗 Symlinking dotfiles..."

# Helper function for symlinks
link_file() {
    local src="$1"
    local dst="$2"
    mkdir -p "$(dirname "$dst")"
    if [ -f "$dst" ] || [ -L "$dst" ]; then
        echo "Backing up existing $dst to $dst.bak"
        mv "$dst" "$dst.bak"
    fi
    ln -sf "$src" "$dst"
    echo "Linked $src -> $dst"
}

link_file "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
[ -f "$DOTFILES/zsh/.p10k.zsh" ] && link_file "$DOTFILES/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
link_file "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"
link_file "$DOTFILES/ghostty/config" "$HOME/.config/ghostty/config"
[ -f "$DOTFILES/aerospace/.aerospace.toml" ] && link_file "$DOTFILES/aerospace/.aerospace.toml" "$HOME/.aerospace.toml"

echo "✅ All dotfiles symlinked successfully!"
