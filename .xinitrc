export GTK_IM_MODULE=yong
export QT_IM_MODULE=yong
export XMODIFIERS="@im=yong"
export DESKTOP_ENV="DWM"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

if [ -e $HOME/.jpg ]; then
    habak $HOME/.jpg
fi

/home/osily/.bin/show

wmname LG3D

if [ -e /usr/bin/synclient ]; then
    synclient TapButton1=1
    synclient HorizEdgeScroll=1
    synclient VertEdgeScroll=1
    synclient ClickPad=0
    synclient RBCornerButton=3
fi &

yong -d
xmodmap $HOME/.xmodmaprc
exec dwm
