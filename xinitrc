cd ${HOME}

xrandr --output HDMI-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DVI-I-1 --mode 1360x768 --pos 1920x0 --rotate normal --output DP-1 --off

xset +fp /home/mitch/usr/fonts
xrdb load /home/mitch/etc/Xresources
xmodmap ${HOME}/etc/Xmodmap
mouse_accel &
xset b off
xbacklight -set 90
xbindkeys &

for i in bar sleep ; do
    pkill -9 $i
done > /dev/null 2>&1

case "$(basename $(file -b -i -L ${HOME}/var/tmp/wall))" in
    *png*|*jpg*|*jpeg*) feh --bg-fill --no-fehbg ${HOME}/var/tmp/wall ;;
    *gif*|*webm*|*mp4*|*mkv*) mpvbg ${HOME}/var/tmp/wall
esac > /dev/null 2>&1 &

! pgrep -f clip > /dev/null &&
    clip --daemon &

#! pgrep -f xbanish > /dev/null &&
#    xbanish &

compton &

bar > /dev/null 2>&1 &

batmon &

#! pgrep -f torrent-queue > /dev/null &&
#    torrent-queue > /dev/null &

#! pgrep -f ytdl-queue > /dev/null &&
#    ytdl-queue > /dev/null &

pulseaudio --start --exit-idle-time=-1 &

# if dwm crashes, relaunch
# if I exit dwm, close
while true ; do
    dwm && break || continue
done > /dev/null 2> /tmp/dwm_err.log
