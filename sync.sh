#!/usr/bin/env bash

DOTFILES_DIR="$HOME/dotfiles"
PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.local/bin:$PATH"

cd "$DOTFILES_DIR" || exit 1

# Helper to avoid copying symlinks to themselves
sync_file() {
    local src="$1"
    local dst="$2"
    [ ! -e "$src" ] && return 0
    if [ "$(realpath "$src" 2>/dev/null)" = "$(realpath "$dst" 2>/dev/null)" ]; then
        return 0
    fi
    mkdir -p "$(dirname "$dst")"
    cp "$src" "$dst" 2>/dev/null || true
}

# Update Brewfile if on macOS / brew is available
if command -v brew &>/dev/null; then
    brew bundle dump --file="$DOTFILES_DIR/Brewfile" --force &>/dev/null
fi

# Sync cross-platform configuration files
sync_file "$HOME/.zshrc" "$DOTFILES_DIR/zsh/.zshrc"
sync_file "$HOME/.p10k.zsh" "$DOTFILES_DIR/zsh/.p10k.zsh"
sync_file "$HOME/.zsh_plugins.txt" "$DOTFILES_DIR/zsh/.zsh_plugins.txt"
sync_file "$HOME/.gitconfig" "$DOTFILES_DIR/git/.gitconfig"
sync_file "$HOME/.config/ghostty/config" "$DOTFILES_DIR/ghostty/config"
[ -d "$HOME/.config/btop" ] && cp -r "$HOME/.config/btop/"* "$DOTFILES_DIR/btop/" 2>/dev/null || true

# macOS-specific configs
sync_file "$HOME/.aerospace.toml" "$DOTFILES_DIR/aerospace/.aerospace.toml"
sync_file "$HOME/.config/aerospace/aerospace.toml" "$DOTFILES_DIR/aerospace/.aerospace.toml"
[ -d "$HOME/.config/borders" ] && cp -r "$HOME/.config/borders/"* "$DOTFILES_DIR/borders/" 2>/dev/null || true
[ -d "$HOME/.config/AutoRaise" ] && cp -r "$HOME/.config/AutoRaise/"* "$DOTFILES_DIR/AutoRaise/" 2>/dev/null || true
[ -d "$HOME/.config/sketchybar" ] && mkdir -p "$DOTFILES_DIR/sketchybar" && cp -r "$HOME/.config/sketchybar/"* "$DOTFILES_DIR/sketchybar/" 2>/dev/null || true

# Linux-specific configs
sync_file "$HOME/.config/sway/config" "$DOTFILES_DIR/sway/config"
sync_file "$HOME/.config/waybar/config.jsonc" "$DOTFILES_DIR/waybar/config.jsonc"
sync_file "$HOME/.config/waybar/style.css" "$DOTFILES_DIR/waybar/style.css"
sync_file "$HOME/.config/dunst/dunstrc" "$DOTFILES_DIR/dunst/dunstrc"
sync_file "$HOME/.local/share/rofi/themes/catppuccin-mocha.rasi" "$DOTFILES_DIR/rofi/catppuccin-mocha.rasi"

# Check for git changes
if [[ -n $(git status --porcelain) ]]; then
    echo "[$(date)] Changes detected. Staged changes ready."
    git status -s
else
    echo "[$(date)] No changes detected in dotfiles."
fi
