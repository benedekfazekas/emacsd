; testing purposes
(setq user-emacs-directory "~/emacsd/")

;; init package to install use-package
(require 'package)

(dolist (source
         '(("melpa" . "https://melpa.org/packages/")
           ("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")))
  (add-to-list 'package-archives source t))

;; keep the installed packages in .emacs.d
(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))
(package-initialize)
;; update the package metadata is the local cache is missing
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-verbose t)

(setq cfgfiles-lisp-dir (expand-file-name "lisp/" user-emacs-directory))

(add-to-list 'load-path cfgfiles-lisp-dir)

;; cfg theme and ux related stuff
(load (concat cfgfiles-lisp-dir "cfg-themes-ux.el"))

;; cfg mac related stuff
(load (concat cfgfiles-lisp-dir "cfg-mac.el"))

;; cfg misc stuff
(load (concat cfgfiles-lisp-dir "cfg-misc.el"))

;; cfg stable packages
(load (concat cfgfiles-lisp-dir "cfg-stable.el"))

;; cfg unstable packages
(load (concat cfgfiles-lisp-dir "cfg-edge.el"))
