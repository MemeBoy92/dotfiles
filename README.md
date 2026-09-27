# 💻 Dotfiles (macOS & Linux Setup)

Personal dotfiles and configuration backup for macOS (Ghostty, Zsh, AeroSpace, SketchyBar, JankyBorders) and Linux (i3wm, Picom, Rofi, Ghostty, Zsh) with a unified Catppuccin Mocha aesthetic.

## 🚀 Setup on a New Machine

```bash
# 1. Clone this repository
git clone https://github.com/MemeBoy92/dotfiles.git ~/dotfiles

# 2. Run the installer script
cd ~/dotfiles && bash install.sh

# 3a. On macOS: Restore Homebrew packages
brew bundle --file=~/dotfiles/Brewfile

# 3b. On Arch/EndeavourOS Linux: Install packages
sudo pacman -S --needed zsh ghostty ttf-meslo-nerd bat eza zoxide btop micro fastfetch uv picom xclip
```
