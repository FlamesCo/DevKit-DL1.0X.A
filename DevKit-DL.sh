#!/bin/bash

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Add devkitPro tap to Homebrew and update repositories
echo "Adding devkitPro tap and updating repositories..."
brew tap devkitpro/devkita64 && brew update

# Install required packages (toolchains)
echo "Installing toolchains: switch-dev"
brew install switch-dev

# Set environment variables in .zshrc or .bash_profile depending on which is being used.
if [ "$SHELL" = "/bin/zsh" ]; then 
  CONFIG_FILE=$HOME/.zshrc 
else 
  CONFIG_FILE=$HOME/.bash_profile 
fi 

grep 'DEVKITPRO' $CONFIG_FILE > /dev/null || {
cat <<EOT >> $CONFIG_FILE
   
export DEVKITPRO="/opt/homebrew/opt/devkita64"
export PATH="\${DEVKITPRO}/tools/bin:\$PATH"

EOT
}

source $CONFIG_FILE

echo ""
echo "Installed successfully! Restart terminal or run 'source \$HOME/.zshrc' or 'source \$HOME/.bash_profile'"