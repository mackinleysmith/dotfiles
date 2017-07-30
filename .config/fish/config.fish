set -x fish_greeting ""
set -x fish_theme robbyrussell

# Path to Oh My Fish install.
set -gx OMF_PATH "$HOME/.local/share/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

set -x fish_plugins git rails rvm bundler node brew

# Rake completion
. $HOME/.dotfiles/.config/fish/rake_completion.fish

# Load oh-my-fish configuration.
. $HOME/.dotfiles/.config/fish/aliases.fish
. $HOME/.dotfiles/.config/fish/secrets.fish

set -x PATH $HOME/.local/bin $PATH
set -x PATH $HOME/.stack/programs/x86_64-osx/ghc-8.0.1/bin $PATH
set -x PATH /Applications/Postgres.app/Contents/Versions/9.5/bin $PATH
set -x PATH ~/.dotfiles/bin $PATH
set -x PATH ~/Library/Android/sdk/platform-tools $PATH
set -x PATH ~/Library/Android/sdk/tools $PATH
set -x PATH $PATH ~/.rvm/gems/ruby-2.2.3/bin

set -x PGHOST /var/pgsql_socket
set -x SSL_CERT_FILE /usr/local/etc/openssl/cert.pem
set -x EDITOR nvim
set -x ANDROID_HOME $HOME/Library/Android/sdk

# rvm default
eval (direnv hook fish)
set -g fish_user_paths "/usr/local/opt/e2fsprogs/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/e2fsprogs/sbin" $fish_user_paths
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
