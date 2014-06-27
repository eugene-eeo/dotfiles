dotfiles
========

My bash and vim settings. Most of my vim settings are for
gVim, but I do use the occasional terminal vim for quick
editing. To install the dotfiles:

```sh
$ git clone http://github.com/eugene-eeo/dotfiles
$ cd dotfiles
$ make apply
```

For additional help on the commands for the makefile, you
can run the command, and you should see theother available
tasks:

```sh
$ make
tasks:
  source     source the dotfiles
  apply      copy dotfiles
  patch      patch the .bash_profile file
```

`bashrc` settings are to customize the prompt and `$PATH`,
most of them were stolen from/inspired by `mistsuhiko`'s
[bashrc](https://github.com/mitsuhiko/dotfiles/blob/master/bash/bashrc),
and I just took the color for keywords from the mustang color
scheme and used it everywhere. It gives my terminal a _heroku_
like look.
