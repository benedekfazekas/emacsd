;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;; disable the annoying bell ring
(setq ring-bell-function 'ignore)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)

;; todo: nick bbatsov's
(setq frame-title-format "%b")
(setq inhibit-splash-screen t)
(set-face-attribute 'default nil :height 130)

;; Scrolling
(setq scroll-step 1)

;; show time
;;(setq display-time-24hr-format t)
;;(setq display-time-load-average t)
;;(display-time)

;; show column number
(column-number-mode t)

;; y/n hassle
(fset 'yes-or-no-p 'y-or-n-p)

;; set a nice split window threshold
(setq split-width-threshold 120)

;; go on, prettify
(global-prettify-symbols-mode 1)

;; Parenthesis
(show-paren-mode)

;; Dont like trailing whitespaces
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; load sql creds from home
(load "~/sqldefs.el")

;; no indent with tabs
(setq-default indent-tabs-mode nil)

;; comment/uncomment sexp (Malabarba)
(load (concat cfgfiles-lisp-dir "sotlisp.el"))
