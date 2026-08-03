#!/usr/bin/env bash

DOTFILES_DIR="$HOME/dotfiles"
PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

cd "$DOTFILES_DIR" || exit 1

# Update Brewfile
brew bundle dump --file="$DOTFILES_DIR/Brewfile" --force &>/dev/null

# Sync configuration files
[ -f "$HOME/.zshrc" ] && cp "$HOME/.zshrc" "$DOTFILES_DIR/zsh/.zshrc"
[ -f "$HOME/.p10k.zsh" ] && cp "$HOME/.p10k.zsh" "$DOTFILES_DIR/zsh/.p10k.zsh"
[ -f "$HOME/.gitconfig" ] && cp "$HOME/.gitconfig" "$DOTFILES_DIR/git/.gitconfig"
[ -f "$HOME/.aerospace.toml" ] && cp "$HOME/.aerospace.toml" "$DOTFILES_DIR/aerospace/.aerospace.toml"
[ -f "$HOME/.config/aerospace/aerospace.toml" ] && cp "$HOME/.config/aerospace/aerospace.toml" "$DOTFILES_DIR/aerospace/.aerospace.toml"
[ -f "$HOME/.config/ghostty/config" ] && cp "$HOME/.config/ghostty/config" "$DOTFILES_DIR/ghostty/config"
[ -d "$HOME/.config/borders" ] && cp -r "$HOME/.config/borders/"* "$DOTFILES_DIR/borders/" 2>/dev/null || true
[ -d "$HOME/.config/AutoRaise" ] && cp -r "$HOME/.config/AutoRaise/"* "$DOTFILES_DIR/AutoRaise/" 2>/dev/null || true
[ -d "$HOME/.config/btop" ] && cp -r "$HOME/.config/btop/"* "$DOTFILES_DIR/btop/" 2>/dev/null || true
[ -d "$HOME/.config/sketchybar" ] && mkdir -p "$DOTFILES_DIR/sketchybar" && cp -r "$HOME/.config/sketchybar/"* "$DOTFILES_DIR/sketchybar/" 2>/dev/null || true

# Check for git changes
if [[ -n $(git status --porcelain) ]]; then
    echo "[$(date)] Changes detected. Staging and pushing to GitHub..."
    git add .
    git commit -m "Auto-sync dotfiles: $(date '+%Y-%m-%d %H:%M:%S')"
    git push origin main
else
    echo "[$(date)] No changes detected in dotfiles."
fi
