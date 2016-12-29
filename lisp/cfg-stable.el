;; stable packages

(use-package
 magit
 :ensure t
 :pin melpa-stable
 :bind ("C-x g" . magit-status))
