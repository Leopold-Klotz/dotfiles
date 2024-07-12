#!/bin/bash

# Define dotfiles directory
DOTFILES_DIR="$HOME/dotfiles"

# Create symlinks
ln -sf "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"

# If .bash_profile doesn't exist, create it and source .bashrc
if [ ! -f "$HOME/.bash_profile" ]; then
    echo "[ -f ~/.bashrc ] && source ~/.bashrc" > "$HOME/.bash_profile"
fi

# Set up Vim
echo "Setting up Vim..."
mkdir -p "$HOME/.vim/autoload" "$HOME/.vim/plugged"

# Install vim-plug if not found
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    echo "Installing vim-plug..."
    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install Vim plugins
echo "Installing Vim plugins..."
vim +PlugInstall +qall

# Install additional Vim dependencies
echo "Installing additional Vim dependencies..."
mkdir -p "$HOME/.vim/colors"
# Download colorscheme if not present
if [ ! -f "$HOME/.vim/colors/angr.vim" ]; then
    curl -fLo "$HOME/.vim/colors/angr.vim" --create-dirs \
        https://raw.githubusercontent.com/zacanger/angr.vim/master/colors/angr.vim
fi

# Set up custom Vim directories
mkdir -p "$HOME/.vim/backup" "$HOME/.vim/swap" "$HOME/.vim/undo"

# Set zsh as the default shell if it's installed
if command -v zsh &> /dev/null && [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
    echo "Changed default shell to zsh. Please log out and back in for the change to take effect."
fi

echo "Dotfiles and Vim setup complete!"
echo "Note: Some changes may require a restart of your terminal or a new login session."
