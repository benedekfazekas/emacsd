;; stable packages

(use-package
 magit
 :ensure t
 :pin melpa-stable
 :bind ("C-x g" . magit-status))

(use-package
 paredit
 :ensure t
 :pin melpa-stable
 :config
 (add-hook 'lisp-mode-hook 'paredit-mode)
 (add-hook 'emacs-lisp-mode-hook 'paredit-mode))

(use-package
 rainbow-delimiters
 :ensure t
 :pin melpa-stable
 :config
 (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package
 yasnippet
 :ensure t
 :pin melpa-stable)

(use-package
 smart-mode-line
 :ensure t
 :pin melpa-stable
 :config
 (setq sml/no-confirm-load-theme t)
 (sml/setup)
 (add-to-list 'sml/replacer-regexp-list '("^~/Downloads/" ":Dwn:") t)
 (add-to-list 'sml/replacer-regexp-list '("^~/projects/tmp/" ":projtmp:") t)
 (add-to-list 'sml/replacer-regexp-list '("^~/projects/" ":proj:") t)
 (add-to-list 'sml/replacer-regexp-list '("^/tmp/" ":TMP:") t))
