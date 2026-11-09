#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
BACKUP_ROOT="${XDG_STATE_HOME:-$HOME/.local/state}/akkad/backups"
STAMP="$(date +%Y%m%d-%H%M%S)"

say() { printf '\033[1;36m[AKKAD]\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m[WARN]\033[0m %s\n' "$*" >&2; }
die() { printf '\033[1;31m[ERROR]\033[0m %s\n' "$*" >&2; exit 1; }

[[ $EUID -ne 0 ]] || die "Run this installer as your normal user, not with sudo."
command -v pacman >/dev/null 2>&1 || die "This installer is for Arch Linux and Arch-based systems."
command -v git >/dev/null 2>&1 || die "Install git first: sudo pacman -S git"

PACKAGES=()
while IFS= read -r line; do
  line="${line%%#*}"
  line="${line//[[:space:]]/}"
  [[ -n "$line" ]] && PACKAGES+=("$line")
done < "$ROOT/packages/base.txt"

say "AKKAD desktop foundation"
say "This will install packages and place configuration under: $CONFIG_HOME"
say "Your existing desktop, login manager, bootloader and GPU settings will not be changed."
printf '\n'
printf 'Packages to install:\n'
printf '  %s\n' "${PACKAGES[@]}"
printf '\n'
read -r -p "Continue with package installation and configuration? [y/N] " answer
[[ "${answer,,}" == "y" || "${answer,,}" == "yes" ]] || { say "Cancelled. No changes made."; exit 0; }

say "Refreshing package databases and installing packages..."
sudo pacman -Syu --needed -- "${PACKAGES[@]}"

mkdir -p "$BACKUP_ROOT/$STAMP" "$CONFIG_HOME"
say "Backing up existing configuration directories when present..."
for name in hypr foot fuzzel mako hyprlock hypridle waybar; do
  target="$CONFIG_HOME/$name"
  if [[ -e "$target" ]]; then
    mkdir -p "$BACKUP_ROOT/$STAMP"
    cp -a "$target" "$BACKUP_ROOT/$STAMP/"
    warn "Saved existing $target to $BACKUP_ROOT/$STAMP/$name"
  fi
done

say "Installing AKKAD configuration..."
for source in "$ROOT"/config/*; do
  [[ -d "$source" ]] || continue
  name="$(basename "$source")"
  mkdir -p "$CONFIG_HOME/$name"
  cp -a "$source/." "$CONFIG_HOME/$name/"
done

REPO_HOME="$HOME/.local/share/akkad"
mkdir -p "$HOME/.local/bin" "$(dirname "$REPO_HOME")"
if [[ "$(realpath "$ROOT")" != "$(realpath -m "$REPO_HOME")" ]]; then
  mkdir -p "$REPO_HOME"
  cp -a "$ROOT"/. "$REPO_HOME"/
fi
install -m 755 "$REPO_HOME/scripts/akkad" "$HOME/.local/bin/akkad"
install -m 755 "$REPO_HOME/scripts/akkad-update" "$HOME/.local/bin/akkad-update"
install -m 755 "$REPO_HOME/scripts/akkad-doctor" "$HOME/.local/bin/akkad-doctor"

say "Installation complete."
say "Ensure ~/.local/bin is in PATH, then log out and choose the Hyprland session."
say "Run 'akkad-doctor' after your first login. Backups: $BACKUP_ROOT/$STAMP"
say "Nothing has been enabled to auto-login or replace your display manager."
