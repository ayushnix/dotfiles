#!/bin/sh
#
# this is just a wrapper script for greetd so that it can launch sway with the
# required env vars

# source, and export, env vars that are needed globally
. /etc/greetd/linux-env

# source, and export, env vars needed for wayland compositors
. /etc/greetd/wayland-env

# export env vars needed for only for sway
export _JAVA_AWT_WM_NONREPARENTING=1
export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_DESKTOP=sway

# launch sway and redirect its output to /tmp to prevent spam in syslog from
# xwayland and libinput
/usr/bin/sway > "$(mktemp)" 2>&1
