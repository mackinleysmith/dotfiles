# dotfiles
My shell configuration.

----------

Installation
============

    git clone git@github.com:smit1625/dotfiles.git ~/.dotfiles
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    ln -s ~/.dotfiles/.config/fish/config.fish ~/.config/fish/config.fish
    ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
    ln -s ~/.dotfiles/tmuxinator ~/.tmuxinator
    ln -s ~/.dotfiles/irb/.irbrc ~/.irbrc

After that, open each vim and run `:BundleInstall`.
