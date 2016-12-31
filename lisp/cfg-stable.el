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
 yasnippet
 :ensure t
 :pin melpa-stable)
