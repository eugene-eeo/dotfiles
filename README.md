# dotfiles

My personal configuration for everything I use on
(mostly) a daily basis. Some parts are unshamefully
stolen from other dotfiles.

> Yes I still use makefiles. Get off my lawn.

```sh
$ sudo cp ./systemd/i3lock@.service /etc/systemd/system/i3lock@.service
$ systemctl enable "i3lock@$(whoami)"
$ cd hc-gnome   # shamefully stolen from i3-gnome with changes
$ sudo make install
$ cd -
$ make # repo -> home
```

This repo is meant as a single source of truth for the
dotfiles on my system. Works on Ubuntu.

## multi monitors

bookmark because I always forget:

```sh
xrandr --output DP-1 --auto --same-as e-DP1 --mode 1920x1080 # mirror
xrandr --output DP-1 --auto --right-of e-DP1 # independent
xrandr --output DP-1 --off                   # turn off/unplug
```
