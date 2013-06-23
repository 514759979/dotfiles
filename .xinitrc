export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

slock &

mkdir /tmp/.tmp /tmp/.cache

wmname LG3D

fcitx -d
$HOME/.bin/show
habak $HOME/.jpg &>/dev/null
sleep 0.2 && xmodmap $HOME/.xmodmaprc &

synclient TapButton1=1
synclient HorizEdgeScroll=1
synclient VertEdgeScroll=1
synclient ClickPad=0
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 8 1
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 8 2

exec dwm
