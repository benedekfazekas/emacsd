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

(use-package
  xkcd
  :ensure t
  :pin melpa-stable
  :config
  (add-hook 'emacs-startup-hook 'xkcd-get-latest))

(use-package uniquify
  ;; make duplicate buffer names unique
  :config
  (setq uniquify-buffer-name-style 'forward))

(use-package
  web-mode
  :ensure t
  :pin melpa-stable
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (defun bf--web-mode-hook ()
    "Hooks for Web mode."
    (setq web-mode-markup-indent-offset 2)
    (local-set-key (kbd "RET") 'newline-and-indent))
  (add-hook 'web-mode-hook  'bf--web-mode-hook))
