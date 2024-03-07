#!/bin/sh

# Start a new tmux session
tmux new-session -d -s vm_network

# Enable mouse support
tmux set-option -g -t vm_network mouse on

# Split the window into three vertical panes
tmux split-window -h -t vm_network
tmux split-window -h -t vm_network:0.1

# Equalise the panes
tmux set-option -w -t vm_network main-pane-height 5
tmux select-layout -t vm_network main-horizontal

# Or resize if necessary
# tmux resize-pane -t vm_network:0.0 -x 33%
# tmux resize-pane -t vm_network:0.1 -x 50%

# Execute commands in each pane.
tmux send-keys -t vm_network:0.0 './vm-router.sh' C-m
tmux send-keys -t vm_network:0.1 './vm1.sh' C-m
tmux send-keys -t vm_network:0.2 './vm2.sh' C-m

# Attach to the tmux session
tmux attach-session -t vm_network
