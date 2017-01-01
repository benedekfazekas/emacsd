(load-file "customize.el")

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

;; make duplicate buffer names unique
(setq uniquify-buffer-name-style 'forward)

;; comment/uncomment sexp (Malabarba)
(load (concat cfgfiles-lisp-dir "sotlisp.el"))
