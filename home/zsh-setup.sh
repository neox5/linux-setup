#!/bin/sh

ZSHRC="$HOME/.zshrc"
OMZ_DIR="$HOME/.oh-my-zsh"
PLUGINS_DIR="$OMZ_DIR/custom/plugins"
FONT_DIR="$HOME/.local/share/fonts/MesloLGS-NF"
FONT_URLS=(
  "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
  "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
  "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
  "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"
)

# Oh-my-zsh
# ---------
if [ ! -d "$OMZ_DIR" ]; then
  # Install Oh My Zsh with RUNZSH="no" to not switch to zsh after installation
  RUNZSH="no" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  echo "Oh My Zsh installed."
else
  echo "Oh My Zsh is already installed."
fi

# zsh-autosuggestions & zsh-syntax-highlighting
# ---------------------------------------------
if [ ! -d "$PLUGINS_DIR/zsh-autosuggestions" ] || [ ! -d "$PLUGINS_DIR/zsh-syntax-highlighting" ]; then 
  echo "installing zsh-autosuggestions & zsh-syntax-highlighting"
  # Install zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-autosuggestions.git $PLUGINS_DIR/zsh-autosuggestions
  # Install zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $PLUGINS_DIR/zsh-syntax-highlighting

  # Append zshrc plugins
  sed -i '/^plugins=/s/[[:space:]]*)/ zsh-autosuggestions zsh-syntax-highlighting)/' $ZSHRC
else
  echo "zsh-autosuggestions & zsh-syntax-highlighting already installed."
fi

# powerlevel10k theme
# -------------------
if [ ! -d "${OMZ_DIR}/custom/themes/powerlevel10k" ]; then
  # removed ZSH_CUSTOM from git clone
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${OMZ_DIR}/custom/themes/powerlevel10k"
  
  # udpating ZSH_THEME
  echo "updating ZSH_THEME to powerlevel10k/powerlevel10k in .zshrc"
  sed -i 's/^ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' $ZSHRC

  # downloading MesloLGS NF
  echo "downloading MesloFLG NF Font"
  mkdir -p "$FONT_DIR"

  for url in "${FONT_URLS[@]}"; do
    echo "Downloading: $url"
    curl -sLo "$FONT_DIR/$(basename "$url")" $url
  done
  echo "font download competed"
  
  echo "updating font cache"
  fc-cache -f

  echo "Powerlevel10k installed."
  echo -e "\033[1;33mIMPORTANT:\033[0m After restarting the terminal change terminal font to MesloLGS NF before going through \033[1;34mp10k configure\033[0m."
else
  echo "Powerlevel10k is already installed."
fi
