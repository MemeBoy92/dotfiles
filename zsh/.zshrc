# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- Antidote Plugin Manager ---
# Automatically regenerates the static ~/.zsh_plugins.zsh whenever ~/.zsh_plugins.txt changes
zsh_plugins=${ZDOTDIR:-$HOME}/.zsh_plugins
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  (
    if [[ -f /opt/homebrew/opt/antidote/share/antidote/antidote.zsh ]]; then
      source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
    elif [[ -f ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh ]]; then
      source ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh
    elif [[ -f /usr/share/zsh-antidote/antidote.zsh ]]; then
      source /usr/share/zsh-antidote/antidote.zsh
    fi
    antidote bundle <${zsh_plugins}.txt >${zsh_plugins}.zsh
  )
fi
autoload -Uz compinit && compinit -C
[[ -f ${zsh_plugins}.zsh ]] && source ${zsh_plugins}.zsh

# --- User Configuration ---
export EDITOR='micro'
export VISUAL='micro'
export BAT_THEME='Catppuccin Mocha'

# Catppuccin Mocha palette for FZF
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Make tab autocomplete
bindkey '^I' autosuggest-accept

# --- Modern CLI Upgrades ---
eval "$(zoxide init zsh --cmd cd)"
source <(fzf --zsh)

alias ls="eza --icons=always --group-directories-first"
alias ll="eza -la --icons=always --group-directories-first"
alias lt="eza --tree --icons=always --level=2"
alias lta="eza --tree -a --icons=always --level=2"
alias cat="bat"
alias grep="rg"
alias find="fd"
alias ai='ollama run llama3.2'

# uv completion
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"


# Added by Antigravity CLI installer
export PATH="$HOME/.local/bin:$PATH"
