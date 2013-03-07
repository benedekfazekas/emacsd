## Emacs installation

To get started with emacs

- `brew update`
- `brew install emacs --cocoa`
- `ln -s /usr/local/Cellar/emacs/24.2/Emacs.app to /Applications/Emacs.app`

You can't run emacs from the terminal. Go to the applications folder and run it from there, put it in your dock.

## Setup

Emacs config lives in ~/.emacs.d. This emacs config has a few bells and whistles. It uses git submodules so you need to initialise them.

- `cd ~`
- `git clone git@github.com:MailOnline/.emacs.d.git`
- `cd .emacs.d`
- `git submodule init`
- `git submodule update`

Enjoy.

## Alternatives

If you don't like this emacs, checkout `https://github.com/technomancy/emacs-starter-kit` or `https://github.com/overtone/emacs-live` or roll your own from scratch borrowing as you go!

## TODOs

- we should probably remove use of git submodules to have a more stable, entry-level emacs - make use of ELPA or MELPA instead.
