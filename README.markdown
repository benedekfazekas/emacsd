## Setup

This emacs config has a few bells and whistles. To set up git submodule dependencies.

- `cd ~`
- `git clone git@github.com:MailOnline/.emacs.d.git`
- `git submodule init`
- `git submodule update`

Enjoy.

## Emacs installation

To get started with emacs

- `brew update`
- `brew install emacs --cocoa`

- copy, move or symlink /usr/local/Cellar/emacs/24.2/Emacs.app to /Applications/Emacs.app

## Alternatives

If you don't like this emacs, checkout `https://github.com/technomancy/emacs-starter-kit` or `https://github.com/overtone/emacs-live` or roll your own from scratch borrowing as you go!

## TODOs

- we should probably remove use of git submodules to have a more stable, entry-level emacs - make use of ELPA or MELPA instead.
