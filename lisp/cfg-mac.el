(setq mac-option-modifier 'none)
(setq mac-command-modifier 'meta)

;; for atreus
;;(setq mac-option-modifier 'meta)
;;(setq mac-command-modifier 'super)

;; here now, without mac-emacs would be much more involved to configure this
;; nice font with ligatures
(when (window-system)
  (set-default-font "Fira Code"))
(mac-auto-operator-composition-mode)

(setq browse-url-chrome-program "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome")

(use-package
 exec-path-from-shell
 :ensure t
 :pin melpa-stable
 :config
 (exec-path-from-shell-initialize))
