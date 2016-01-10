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
set fish_custom $HOME/.dotfiles/oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish
. $HOME/.dotfiles/.config/fish/aliases.fish

set PATH ~/.cabal/bin $PATH
set PATH /Library/Haskell/bin $PATH
set PATH ~/dotfiles/bin $PATH
set PATH ~/.rvm/gems/ruby-2.2.2/bin $PATH

set -x EDITOR nvim
