#
# PATH=.config/i3/config
#
# This file has been auto-generated by i3-config-wizard(1).
# It will not be overwritten, so edit it as you like.
#
# Should you change your keyboard layout some time, delete
# this file and re-run i3-config-wizard(1).
#

# i3 config file (v4)
#
# Please see http://i3wm.org/docs/userguide.html for a complete reference!

set $mod Mod4

# Font for window titles. Will also be used by the bar unless a different font
# is used in the bar {} block below.
font pango:NotoSans 11

# Gaps global
for_window [class="^.*"] border pixel 4
#smart_gaps on
#gaps inner 15 
#gaps outer 10

# Monitor controls
bindsym $mod+Shift+m exec --no-startup-id ~/dotty2hotty/screenlayout/laptop_screen.sh
bindsym $mod+Shift+n exec --no-startup-id ~/dotty2hotty/screenlayout/hdmi.sh

# exec_always stuff
exec_always --no-startup-id $HOME/dotty2hotty/scripterino/polybar_launch.sh
# exec_always feh --bg-scale /home/kartik/.wallpaper.png
exec_always --no-startup-id $HOME/dotty2hotty/scripterino/wall.sh

# exec startup
exec --no-startup-id unclutter --timeout 3
exec --no-startup-id compton -b
exec --no-startup-id redshift-gtk
exec --no-startup-id unclutter --timeout 2 --ignore-scrolling
# exec xrdb ~/.Xresources

# This font is widely installed, provides lots of unicode glyphs, right-to-left
# text rendering and scalability on retina/hidpi displays (thanks to pango).
#font pango:DejaVu Sans Mono 8

# Before i3 v4.8, we used to recommend this one as the default:
# font -misc-fixed-medium-r-normal--13-120-75-75-C-70-iso10646-1
# The font above is very space-efficient, that is, it looks good, sharp and
# clear in small sizes. However, its unicode glyph coverage is limited, the old
# X core fonts rendering does not support right-to-left and this being a bitmap
# font, it doesn’t scale on retina/hidpi displays.

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# start a terminal
#set $TERMINAL termite
bindsym $mod+Return exec i3-sensible-terminal

# kill focused window
bindsym $mod+Shift+q kill

# start dmenu (a program launcher)
bindsym $mod+d exec --no-startup-id zsh -i -c "rofi -show run"
bindsym $mod+Tab exec --no-startup-id rofi -show window
# bindsym $mod+Escape exec --no-startup-id ~/dotty2hotty/scripterino/rofi-power

# Power menu mode
set $sysmenu " [h]ibernate [p]oweroff [r]eboot [s]uspend "
bindsym $mod+Escape      mode $sysmenu

mode $sysmenu {
    bindsym h         mode "default"; exec "systemctl hibernate"
    bindsym p         mode "default"; exec "systemctl poweroff"
    bindsym r         mode "default"; exec "systemctl reboot"
    bindsym s         mode "default"; exec "systemctl suspend"
    bindsym Return    mode "default"
    bindsym Escape    mode "default"
}

# There also is the (new) i3-dmenu-desktop which only displays applications
# shipping a .desktop file. It is a wrapper around dmenu, so you need that
# installed.
# bindsym $mod+d exec --no-startup-id i3-dmenu-desktop

# change focus
bindsym $mod+h focus left
bindsym $mod+k focus down
bindsym $mod+j focus up
bindsym $mod+l focus right

# alternatively, you can use the cursor keys:
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# move focused window
bindsym $mod+Shift+h move left
bindsym $mod+Shift+k move down
bindsym $mod+Shift+j move up
bindsym $mod+Shift+l move right

# alternatively, you can use the cursor keys:
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# split in horizontal orientation
bindsym $mod+g split h

# split in vertical orientation
bindsym $mod+v split v

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen toggle

# change container layout (stacked, tabbed, toggle split)
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

# toggle tiling / floating
bindsym $mod+Shift+f floating toggle

# change focus between tiling / floating windows
bindsym $mod+space focus mode_toggle

# focus the parent container
bindsym $mod+a focus parent

# focus the child container
#bindsym $mod+d focus child

# mpd player controls
bindsym $mod+slash exec --no-startup-id cmus-remote --pause
bindsym $mod+comma exec --no-startup-id cmus-remote --prev
bindsym $mod+period exec --no-startup-id cmus-remote --next

# Sreen brightness controls
bindsym XF86MonBrightnessUp exec xbacklight -inc 10 # increase screen brightness
bindsym XF86MonBrightnessDown exec xbacklight -dec 10 # decrease screen brightness

# Pulse Audio controls
bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%
bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%
bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle

# ALSA Volume 
# bindsym XF86AudioRaiseVolume exec amixer -q set Master 2dB+ unmute
# bindsym XF86AudioLowerVolume exec amixer -q set Master 2dB- unmute
# bindsym XF86AudioMute exec amixer -q set Master toggleControls

# switch to workspace
bindsym $mod+1 workspace 1
bindsym $mod+2 workspace 2
bindsym $mod+3 workspace 3
bindsym $mod+4 workspace 4
bindsym $mod+5 workspace 5
bindsym $mod+6 workspace 6
bindsym $mod+7 workspace 7
bindsym $mod+8 workspace 8
bindsym $mod+9 workspace 9
bindsym $mod+0 workspace 10

# move focused container to workspace
bindsym $mod+Shift+1 move container to workspace 1
bindsym $mod+Shift+2 move container to workspace 2
bindsym $mod+Shift+3 move container to workspace 3
bindsym $mod+Shift+4 move container to workspace 4
bindsym $mod+Shift+5 move container to workspace 5
bindsym $mod+Shift+6 move container to workspace 6
bindsym $mod+Shift+7 move container to workspace 7
bindsym $mod+Shift+8 move container to workspace 8
bindsym $mod+Shift+9 move container to workspace 9
bindsym $mod+Shift+0 move container to workspace 10

# reload the configuration file
bindsym $mod+Shift+c reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart
# exit i3 (logs you out of your X session)
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

# resize window (you can also use the mouse for that)
mode "resize" {
        # These bindings trigger as soon as you enter the resize mode

        # Pressing left will shrink the window’s width.
        # Pressing right will grow the window’s width.
        # Pressing up will shrink the window’s height.
        # Pressing down will grow the window’s height.
        bindsym j resize shrink width 10 px or 10 ppt
        bindsym k resize grow height 10 px or 10 ppt
        bindsym l resize shrink height 10 px or 10 ppt
        bindsym semicolon resize grow width 10 px or 10 ppt

        # same bindings, but for the arrow keys
        bindsym Left resize shrink width 10 px or 10 ppt
        bindsym Down resize grow height 10 px or 10 ppt
        bindsym Up resize shrink height 10 px or 10 ppt
        bindsym Right resize grow width 10 px or 10 ppt

        # back to normal: Enter or Escape
        bindsym Return mode "default"
        bindsym Escape mode "default"
}

# Color stuff
#
#set $bg-color            #2f343f
#set $inactive-bg-color   #4f4646
#set $text-color          #f3f4f5
#set $inactive-text-color #676e7D
#set $urgent-bg-color     #e53935
#set $indicator-color     #8a93a8

set $base03           #002b36
set $base02           #073642
set $base01           #586e75
set $base00           #657b83
set $base0            #839496
set $base1            #93a1a1
set $base2            #eee8d5
set $base3            #fdf6e3
set $yellow           #b58900
set $orange           #cb4b16
set $red              #dc322f
set $magenta          #d33682
set $violet           #6c71c4
set $blue             #268bd2
set $cyan             #2aa198
set $green            #859900
set $custom           #1c5766

# window colors
#                       border             background         text                 indicator
client.focused          $violet            $violet            $base3               $orange
client.unfocused        $base02            $base02            $base1               $base01
client.focused_inactive $base02            $base02            $base2               $violet
client.urgent           $magenta           $magenta           $base3               $red

bindsym $mod+r mode "resize"

# Window settings
for_window [class="feh"] border normal, floating enable
for_window [class="Pinentry"] border normal, floating enable
for_window [class="mpv"] border normal, floating enable
for_window [class="explorer.exe"] border normal, floating enable

# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
#bar {
#  status_command i3blocks -c ~/.config/i3/i3blocks.conf
#  colors {
#    background $bg-color
#    separator #757575
#    #                  border             bg                 text
#    focused_workspace  $bg-color          $bg-color          $text-color
#    inactive_workspace $inactive-bg-color $inactive-bg-color $inactive-text-color
#    urgent_workspace   $urgent-bg-color   $urgent-bg-color   $text-color
#  }
#}
