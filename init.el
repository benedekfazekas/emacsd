;;; init.el -- Emacs config

;; Author: Benedek Fazekas <benedek.fazekas@gmail.com>
;; URL: https://github.com/benedekfazekas/emacsd

;;; Commentary:

;; I have forgotten much that I thought I knew, and learned again much
;; that I had forgotten. I can see many things far off, but many things
;; that are close at hand I cannot see.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (xkcd web-mode markdown-mode nameless clj-refactor company cider clojure-mode smart-mode-line yasnippet rainbow-delimiters paredit magit color-theme-sanityinc-tomorrow exec-path-from-shell use-package)))
 '(safe-local-variable-values
   (quote
    ((bug-reference-bug-regexp . "#\\(?2:[[:digit:]]+\\)")
     (ffip-patterns "*.org" "*.rb" "*.sh" "*.md" "*.css" "*.scss" "Rakefile" "Procfile" "Capfile" "*.sql" "*.json" "*.haml" "*.js")
     (ffip-find-options . "-not -regex \".*out-.*\"")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rainbow-delimiters-depth-2-face ((t (:foreground "selectedMenuItemColor"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "Yellow"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "Green"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "Orange"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "Magenta"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "Brown"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "Purple"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "White"))))
 '(rainbow-delimiters-unmatched-face ((t (:foreground "Red")))))

;; Always load newest byte code
(setq load-prefer-newer t)

(setq cfgfiles-lisp-dir (expand-file-name "lisp/" user-emacs-directory))

(add-to-list 'load-path cfgfiles-lisp-dir)

;; cfg core emacs
(load "cfg-emacs-core.el")

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

;; cfg mac related stuff
(when (memq window-system '(mac))
  (load "cfg-mac.el"))

;; cfg theme related stuff
(load "cfg-themes.el")

;; cfg misc stuff
(load "cfg-misc.el")

;; cfg packages
(load "cfg-packages.el")

;; aws authenticate
(load "aws.el")

;;; init.el ends here
