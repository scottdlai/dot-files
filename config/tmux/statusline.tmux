### colorscheme ###
set -g default-terminal "tmux-256color"
set -as terminal-overrides ",xterm-256:RGB"

_tmux_color_block_primary="white"
_tmux_color_client_prefix="brightgreen"
_tmux_color_synchronized="brightblue"
_tmux_color_primary_mode="brightyellow"
_tmux_color_active_border="white"
_tmux_color_text_primary="brightwhite"
_tmux_color_text_secondary="brightwhite"
_tmux_color_bg_primary="#272727"
_tmux_color_bg_secondary="brightblack"
_tmux_color_misc="brightcyan"

_tmux_block_color="#{?client_prefix,\
$_tmux_color_client_prefix,\
#{?pane_in_mode,\
$_tmux_color_primary_mode,\
#{?pane_synchronized,$_tmux_color_synchronized,$_tmux_color_block_primary}\
}}"

### status bar ###

# set statusbar update interval
set -g status-interval 15

# Add a blank space between the status line and the windows
set -g status 2
set -g status-format[1] "#[bg=terminal #{E:pane-active-border-style}]#(printf -- '─%%.0s' {1..#{client_width}})"

set -g status-justify left
set -g status-position top

# change window screen colors
set -wg mode-style "bg=$_tmux_color_primary_mode fg=$_tmux_color_bg_primary,bold"

# pane border
set -g pane-active-border-style "\
fg=#{?client_prefix,\
$_tmux_color_client_prefix,\
#{?pane_in_mode,\
$_tmux_color_primary_mode,\
#{?pane_synchronized,$_tmux_color_synchronized,$_tmux_color_active_border}\
}}\
"
set -g pane-border-style "fg=$_tmux_color_bg_secondary"

# message info
set -g message-style "bg=$_tmux_color_bg_secondary fg=default"

# pane number display
set -g display-panes-active-colour "$_tmux_color_primary_mode"
set -g display-panes-colour "default"

# clock
set -wg clock-mode-colour "$_tmux_color_primary_mode"

# copy mode highlighting
%if #{>=:#{version},3.2}
    set -wg copy-mode-match-style "fg=$_tmux_color_primary_mode"
    set -wg copy-mode-current-match-style "bg=$_tmux_color_primary_mode fg=$_tmux_color_bg_primary"
%endif

# default statusbar colors (terminal bg should be #282828)
set -g status-style "bg=terminal fg=$_tmux_color_active_border"

# statusbar formatting
set -g status-left "\
#[bg=$_tmux_color_misc fg=$_tmux_color_bg_primary,bold]#{?rectangle_toggle, R ,}\
#[fg=$_tmux_color_bg_primary,bold bg=$_tmux_block_color] #{session_name} \
#[bg=$_tmux_color_bg_secondary fg=$_tmux_color_text_secondary,nobold]#(pmset -g batt | grep -oE '\\d{1,3}%%' | xargs -I {} echo ' {} ')\
#[bg=default fg=default] %a %b %d %H:%M %Z | \
"

set -g status-right "\
| #{user} \
#[bg=$_tmux_color_bg_secondary, fg=$_tmux_color_text_secondary] #{pane_width}x#{pane_height} \
#[bg=$_tmux_block_color,fg=$_tmux_color_bg_primary,bold]  pane #{pane_index}/#{window_panes}  \
"

# window separators
set -wg window-status-separator " | "

# default window title colors
set -wg window-status-style "#{E:status-style}"

# colors for windows with activity
set -wg window-status-activity-style "bg=$_tmux_color_misc fg=$_tmux_color_bg_primary"

# active window title colors
set -wg window-status-current-style "\
fg=#{?client_prefix,\
$_tmux_color_client_prefix,\
#{?pane_in_mode,\
$_tmux_color_primary_mode,\
#{?pane_synchronized,$_tmux_color_synchronized,$_tmux_color_text_primary}\
}},bold\
"

set -wg window-status-format "#{window_index} #{window_name}"
set -wg window-status-current-format "#{E:window-status-format}#F"

set -g status-left-length 200
set -g status-right-length 200
