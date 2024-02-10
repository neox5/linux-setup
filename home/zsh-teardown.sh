#!/bin/sh
# ZSH TEARDOWN SCRIP

OMZ_DIR="$HOME/.oh-my-zsh"
ZSHRC="$HOME/.zshrc"
FONT_DIR="$HOME/.local/share/fonts/MesloLGS-NF"
P10K="$HOME/.p10k.zsh"

# Oh-my-zsh
# ---------
if [ -d "$OMZ_DIR" ]; then
  rm -rf "$OMZ_DIR"
  echo "oh-my-zsh removed."
else
  echo "oh-my-zsh already removed."
fi

# Powerlevel10k - MesloLGS NF
# ---------------------------
if [ -d "$FONT_DIR" ]; then
  rm -rf "$FONT_DIR"
  echo "MesloLGS NF fonts removed."
  # Updating font cache after removal
  fc-cache -f
else
  echo "MesloLGS NF fonts already removed."
fi

# Powerlevel10k Configuration File
# --------------------------------
if [ -f "$P10K" ]; then
  rm "$P10K"
  echo ".p10k.zsh removed."
else
  echo ".p10k.zsh already removed."
fi

# restore .zshrc
rm $ZSHRC
mv "$ZSHRC".pre-oh-my-zsh $ZSHRC
echo ".zshrc restored"
