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

# Cross-platform dotfiles
link_file "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
[ -f "$DOTFILES/zsh/.p10k.zsh" ] && link_file "$DOTFILES/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
[ -f "$DOTFILES/zsh/.zsh_plugins.txt" ] && link_file "$DOTFILES/zsh/.zsh_plugins.txt" "$HOME/.zsh_plugins.txt"
link_file "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"
link_file "$DOTFILES/ghostty/config" "$HOME/.config/ghostty/config"
[ -f "$DOTFILES/btop/btop.conf" ] && link_file "$DOTFILES/btop/btop.conf" "$HOME/.config/btop/btop.conf"

# OS-Specific dotfiles
if [[ "$(uname)" == "Darwin" ]]; then
    echo "🍎 Detected macOS configuration..."
    [ -f "$DOTFILES/aerospace/.aerospace.toml" ] && link_file "$DOTFILES/aerospace/.aerospace.toml" "$HOME/.aerospace.toml"
    [ -f "$DOTFILES/borders/bordersrc" ] && link_file "$DOTFILES/borders/bordersrc" "$HOME/.config/borders/bordersrc"
    [ -d "$DOTFILES/sketchybar" ] && ln -sfn "$DOTFILES/sketchybar" "$HOME/.config/sketchybar"
elif [[ "$(uname)" == "Linux" ]]; then
    echo "🐧 Detected Linux configuration..."
    [ -f "$DOTFILES/i3/config" ] && link_file "$DOTFILES/i3/config" "$HOME/.config/i3/config"
    [ -f "$DOTFILES/i3/i3blocks.conf" ] && link_file "$DOTFILES/i3/i3blocks.conf" "$HOME/.config/i3/i3blocks.conf"
    [ -f "$DOTFILES/picom/picom.conf" ] && link_file "$DOTFILES/picom/picom.conf" "$HOME/.config/picom.conf"
    [ -f "$DOTFILES/dunst/dunstrc" ] && link_file "$DOTFILES/dunst/dunstrc" "$HOME/.config/dunst/dunstrc"
    [ -f "$DOTFILES/greenclip/greenclip.toml" ] && link_file "$DOTFILES/greenclip/greenclip.toml" "$HOME/.config/greenclip.toml"
    [ -f "$DOTFILES/rofi/catppuccin-mocha.rasi" ] && link_file "$DOTFILES/rofi/catppuccin-mocha.rasi" "$HOME/.local/share/rofi/themes/catppuccin-mocha.rasi"
fi

echo "✅ All dotfiles symlinked successfully!"
