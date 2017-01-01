(setq mac-option-modifier 'none)
(setq mac-command-modifier 'meta)

;; here now, without mac-emacs would be much more involved to configure this
;; nice font with ligatures
(when (window-system)
  (set-default-font "Fira Code"))
(mac-auto-operator-composition-mode)

(use-package
 exec-path-from-shell
 :ensure t
 :pin melpa-stable
 :config
 (when (memq window-system '(mac ns))
   (exec-path-from-shell-initialize)))
