;;(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

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
(setq split-width-threshold 120)

(global-prettify-symbols-mode 1)
