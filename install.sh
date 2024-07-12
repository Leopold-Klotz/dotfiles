#!/bin/bash

# Define dotfiles directory
DOTFILES_DIR="$HOME/dotfiles"

# Create symlinks
ln -sf "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
ln -sf "$DOTFILES_DIR/.vim" "$HOME/.vim"

# If .bash_profile doesn't exist, create it and source .bashrc
if [ ! -f "$HOME/.bash_profile" ]; then
    echo "[ -f ~/.bashrc ] && source ~/.bashrc" > "$HOME/.bash_profile"
fi

# Set up Vim
mkdir -p "$HOME/.vim/autoload" "$HOME/.vim/plugged"
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install Vim plugins
vim +PlugInstall +qall

# Set zsh as the default shell if it's installed
if command -v zsh &> /dev/null && [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
    echo "Changed default shell to zsh. Please log out and back in for the change to take effect."
fi

echo "Dotfiles installation complete!"
