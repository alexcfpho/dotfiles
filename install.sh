#!/usr/bin/env bash
#
# Reproduces this machine's Ghostty + zsh setup on a fresh Mac.
# Idempotent: safe to re-run.
#
# Usage: ./install.sh
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

log() { printf '\n\033[1;34m==>\033[0m %s\n' "$1"; }

# --- 1. Homebrew ---
if ! command -v brew >/dev/null 2>&1; then
  log "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  log "Homebrew already installed"
fi

# --- 2. Formulae + casks ---
log "Installing formulae and casks from Brewfile"
brew bundle --file="$DOTFILES_DIR/Brewfile"

# --- 3. Oh My Zsh ---
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  log "Installing Oh My Zsh"
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  log "Oh My Zsh already installed"
fi

clone_or_update() {
  local repo="$1" dest="$2"
  if [[ -d "$dest/.git" ]]; then
    log "Updating $(basename "$dest")"
    git -C "$dest" pull --ff-only
  else
    log "Cloning $(basename "$dest")"
    git clone --depth=1 "$repo" "$dest"
  fi
}

# --- 4. Oh My Zsh plugins/theme ---
clone_or_update https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_or_update https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
clone_or_update https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"

# kubectl-autocomplete: regenerated from the installed kubectl (pulled in as a
# dependency of kubie/kubeseal), matching what's on this machine today.
mkdir -p "$ZSH_CUSTOM/plugins/kubectl-autocomplete"
if command -v kubectl >/dev/null 2>&1; then
  log "Generating kubectl-autocomplete plugin"
  kubectl completion zsh > "$ZSH_CUSTOM/plugins/kubectl-autocomplete/kubectl-autocomplete.plugin.zsh"
else
  log "kubectl not found on PATH yet — skipping kubectl-autocomplete generation, re-run later"
fi

# --- 5. Dotfiles ---
log "Linking zsh dotfiles"
for f in .zshrc .zprofile .p10k.zsh; do
  ln -sf "$DOTFILES_DIR/zsh/$f" "$HOME/$f"
done

# --- 6. Ghostty config + shaders ---
log "Linking Ghostty config"
mkdir -p "$HOME/.config/ghostty"
ln -sf "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"
clone_or_update https://github.com/hackr-sh/ghostty-shaders "$HOME/.config/ghostty/shaders"

# --- 7. Default shell ---
if [[ "$SHELL" != */zsh ]]; then
  log "Setting default shell to zsh"
  chsh -s "$(command -v zsh)"
fi

log "Done. Restart your terminal (or open Ghostty) to pick up the new config."
