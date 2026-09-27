#!/usr/bin/env bash

DOTFILES_DIR="$HOME/dotfiles"
PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.local/bin:$PATH"

cd "$DOTFILES_DIR" || exit 1

# Update Brewfile if on macOS / brew is available
if command -v brew &>/dev/null; then
    brew bundle dump --file="$DOTFILES_DIR/Brewfile" --force &>/dev/null
fi

# Sync cross-platform configuration files
[ -f "$HOME/.zshrc" ] && cp "$HOME/.zshrc" "$DOTFILES_DIR/zsh/.zshrc"
[ -f "$HOME/.p10k.zsh" ] && cp "$HOME/.p10k.zsh" "$DOTFILES_DIR/zsh/.p10k.zsh"
[ -f "$HOME/.zsh_plugins.txt" ] && cp "$HOME/.zsh_plugins.txt" "$DOTFILES_DIR/zsh/.zsh_plugins.txt"
[ -f "$HOME/.gitconfig" ] && cp "$HOME/.gitconfig" "$DOTFILES_DIR/git/.gitconfig"
[ -f "$HOME/.config/ghostty/config" ] && cp "$HOME/.config/ghostty/config" "$DOTFILES_DIR/ghostty/config"
[ -d "$HOME/.config/btop" ] && cp -r "$HOME/.config/btop/"* "$DOTFILES_DIR/btop/" 2>/dev/null || true

# macOS-specific configs
[ -f "$HOME/.aerospace.toml" ] && cp "$HOME/.aerospace.toml" "$DOTFILES_DIR/aerospace/.aerospace.toml"
[ -f "$HOME/.config/aerospace/aerospace.toml" ] && cp "$HOME/.config/aerospace/aerospace.toml" "$DOTFILES_DIR/aerospace/.aerospace.toml"
[ -d "$HOME/.config/borders" ] && cp -r "$HOME/.config/borders/"* "$DOTFILES_DIR/borders/" 2>/dev/null || true
[ -d "$HOME/.config/AutoRaise" ] && cp -r "$HOME/.config/AutoRaise/"* "$DOTFILES_DIR/AutoRaise/" 2>/dev/null || true
[ -d "$HOME/.config/sketchybar" ] && mkdir -p "$DOTFILES_DIR/sketchybar" && cp -r "$HOME/.config/sketchybar/"* "$DOTFILES_DIR/sketchybar/" 2>/dev/null || true

# Linux-specific configs
[ -f "$HOME/.config/i3/config" ] && mkdir -p "$DOTFILES_DIR/i3" && cp "$HOME/.config/i3/config" "$DOTFILES_DIR/i3/config"
[ -f "$HOME/.config/i3/i3blocks.conf" ] && mkdir -p "$DOTFILES_DIR/i3" && cp "$HOME/.config/i3/i3blocks.conf" "$DOTFILES_DIR/i3/i3blocks.conf"
[ -f "$HOME/.config/picom.conf" ] && mkdir -p "$DOTFILES_DIR/picom" && cp "$HOME/.config/picom.conf" "$DOTFILES_DIR/picom/picom.conf"
[ -f "$HOME/.local/share/rofi/themes/catppuccin-mocha.rasi" ] && mkdir -p "$DOTFILES_DIR/rofi" && cp "$HOME/.local/share/rofi/themes/catppuccin-mocha.rasi" "$DOTFILES_DIR/rofi/catppuccin-mocha.rasi"

# Check for git changes
if [[ -n $(git status --porcelain) ]]; then
    echo "[$(date)] Changes detected. Staged changes ready."
    git status -s
else
    echo "[$(date)] No changes detected in dotfiles."
fi
