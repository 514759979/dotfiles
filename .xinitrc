export GTK_IM_MODULE=yong
export QT_IM_MODULE=yong
export XMODIFIERS="@im=yong"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

slock &

wmname LG3D

synclient TapButton1=1
synclient HorizEdgeScroll=1
synclient VertEdgeScroll=1
synclient ClickPad=0

yong -d
$HOME/.bin/show
habak $HOME/.jpg &>/dev/null
xmodmap $HOME/.xmodmaprc

xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 8 1
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 8 2

mkdir /tmp/.t

exec dwm
