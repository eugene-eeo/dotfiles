# dotfiles

My personal configuration for everything I use on
(mostly) a daily basis. Some parts are unshamefully
stolen from other dotfiles. If you're after how to
configure the hottest plugin I most probably do not
have it, I simply have what works for me best.

> Yes I still use makefiles. Get off my lawn.

```sh
$ make          # repo -> home
$ make copy     # home -> repo
```

Usual workflow is to work on dotfiles in *this*
repo and then run `make`, and test the settings.


## Hammerspoon config

Initially I used [Spectacle](https://www.spectacleapp.com/)
because I want a poor man's WM but without having to
read through 100 pages of README and memorise 50 keyboard
shortcuts. But I wanted gaps between windows because they
looked really cool. At the same time I want to turn off gaps
sometimes. So this was born.
