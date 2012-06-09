export GTK_IM_MODULE=xim
export QT_IM_MODULE=xim
export XMODIFIERS="@im=yong"
export DESKTOP_ENV="DWM"
export GTK2_RC_FILES="/home/osily/.gtkrc-2.0"

if [ -e $HOME/.jpg ]; then
    habak $HOME/.jpg
fi

/home/osily/.config/bin/show

wmname LG3D

if [ -e /usr/bin/synclient ]; then
    synclient TapButton1=1
    synclient HorizEdgeScroll=1
    synclient VertEdgeScroll=1
fi &

# for thinkpad trackpoint, middle key scroll screen
if [ -e /usr/bin/xinput ]; then
    sleep 2
    xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 8 2
    xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 8 1
    xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Axes" 8 6 7 4 5
fi &

yong -d
easystroke &
xmodmap $HOME/.xmodmaprc
exec dwm
