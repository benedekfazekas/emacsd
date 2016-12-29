;; (use-package
;;  color-theme-sanityinc-tomorrow-eighties
;;  :ensure t
;;  :config (color-theme-sanityinc-tomorrow-eighties))

(use-package zenburn-theme
  :ensure t
  :config
  (load-theme 'zenburn t))

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
