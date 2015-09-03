# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Theme
set fish_theme robbyrussell
# set fish_theme coffeeandcode

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins autojump bundler
set fish_plugins git rails rvm bundler git node brew

# Path to your custom folder (default path is $FISH/custom)
set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

# Aliases
alias s='spring'
alias vi='/usr/local/Cellar/vim/7.4.488/bin/vim'
alias hvi='vi -u ~/.dotfiles/vim/.vimrc.haskell'
alias hvim='hvi'
alias rvi='vi -u ~/.dotfiles/vim/.vimrc.ruby'
alias rvim='rvi'
alias tivi='vi -u ~/.dotfiles/vim/.vimrc.titanium'
alias tivim='tivi'

set PATH ~/.cabal/bin $PATH
set PATH /Library/Haskell/bin $PATH
set PATH ~/dotfiles/bin $PATH

set EDITOR rvi 
