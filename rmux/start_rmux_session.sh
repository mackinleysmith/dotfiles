#!/bin/sh
local_hostname="$(scutil --get LocalHostName | awk '{print tolower($0)}').local"
project_name=${1:-$(printf '%q\n' "${PWD##*/}")}
socket_path=/tmp/tmate.sock
tmux -S /tmp/tmate.sock new-session -d "env TMUX='' mux start $project_name"
echo ssh $USER@$local_hostname -t \"tmux -S $socket_path -CC attach\"
