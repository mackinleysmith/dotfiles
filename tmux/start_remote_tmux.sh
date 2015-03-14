#!/bin/sh
tmate -S /tmp/tmate.sock new-session -d "env TMUX='' mux start theriverboat_v2"
tmate -S /tmp/tmate.sock wait tmate-ready
tmate -S /tmp/tmate.sock display -p '#{tmate_ssh}'
