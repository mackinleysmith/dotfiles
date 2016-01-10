# Aliases
alias s='spring'
# alias s='zeus'
# alias vi='/usr/local/Cellar/vim/7.4.884/bin/vim'
alias vi='nvim'
alias hvi='vi -u ~/.dotfiles/vim/.vimrc.haskell'
alias hvim='hvi'
alias rvi='vi -u ~/.dotfiles/vim/.vimrc.ruby'
alias rvim='rvi'
alias tivi='vi -u ~/.dotfiles/vim/.vimrc.titanium'
alias tivim='tivi'
alias ardvi='vi -u ~/.dotfiles/vim/.vimrc.arduino'
alias ardvim='ardvi'
alias ctags="`brew --prefix`/bin/ctags"

# function zeus; set ARGS $argv; command zeus "$argv"; set ZE_EC $status; stty sane; if [ $ZE_EC = 2 ]; zeus "$ARGS"; end; end
function fixed_zeus; set ARGS $argv; command zeus $argv; set ZE_EC $status; stty sane; if [ $ZE_EC = 2 ]; fixed_zeus $ARGS; end; end
function guard; stty sane; command guard $argv; end
