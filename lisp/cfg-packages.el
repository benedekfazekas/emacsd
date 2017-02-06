(use-package
 magit
 :ensure t
 :pin melpa-stable
 :bind ("C-x g" . magit-status)
 :config
 (defun bf/magit-cursor-fix ()
   (beginning-of-buffer)
   (when (looking-at "#")
     (forward-line 2)))
 (set-default 'magit-revert-buffers 'silent)
 (set-default 'magit-no-confirm '(stage-all-changes
                                  unstage-all-changes))
 (add-hook 'git-commit-mode-hook bf/magit-cursor-fix))

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

(use-package haml-mode
  :ensure t
  :pin melpa-stable)

;;;;;;;;;;;;;;;;;;;;;;
;; unstable packages
;;;;;;;;;;;;;;;;;;;;;;

(use-package auto-complete
  :ensure t
  :config
  (ac-config-default))

;;;;;;;;;;;;;;
;; Clojure
;;;;;;;;;;;;;;

(defun bf/fancify-symbols ()
  (push '("fn" . (?· (Br . Bl) ?λ)) prettify-symbols-alist)
  (push '("#(" . (?ƒ (Br . Bl) ?\()) prettify-symbols-alist)
  (push '("#{" . (?∈ (Br . Bl) ?\{)) prettify-symbols-alist))

(use-package
 clojure-mode
 :ensure t
 :config
 (add-hook 'clojure-mode-hook 'paredit-mode)
 (add-hook 'clojure-mode-hook 'bf/fancify-symbols))

(use-package
 cider
 :ensure t
 :config
 ;; cider result with nice prefix
 (setq cider-repl-result-prefix ";; contemplate => ")
 ;; nicer font lock in repl
 (setq cider-repl-use-clojure-font-lock t)
 ;; never ending history
 (setq cider-repl-wrap-history t)
 ;; show port on remote repl
 (setq nrepl-buffer-name-show-port t)
 ;; looong history
 (setq cider-repl-history-size 3000)
 ;; todo per project history file with dir local
 ;; global cider history file
 (setq cider-repl-history-file "~/.emacs.d/cider-history")
 ;; error buffer not popping up
 (setq cider-show-error-buffer nil)
 ;; pretty priting
 (setq cider-repl-toggle-pretty-printing t)
 ;; use pprint for now
 (setq cider-pprint-fn 'pprint)
 (add-hook 'cider-repl-mode-hook 'paredit-mode)
 (add-hook 'cider-repl-mode-hook 'bf/fancify-symbols)
 (add-hook 'cider-mode-hook #'eldoc-mode)
 :bind (("C-c n c" . nrepl-close)
        ("C-c n q" . cider-quit)
        ("M-p" . cider-eval-print-last-sexp)
        ("<C-f11>" . cider-jack-in)))

(use-package
 company
 :ensure t
 :config
 (add-hook 'cider-repl-mode-hook 'company-mode)
 (add-hook 'cider-mode-hook 'company-mode))

(use-package
 clj-refactor
 :ensure t
 :config
 (add-hook
  'clojure-mode-hook
  (lambda ()
    (clj-refactor-mode 1)
    ;; insert keybinding setup here
    (cljr-add-keybindings-with-prefix "C-c")))
 (add-hook 'clojure-mode-hook (lambda () (yas/minor-mode 1)))
 ;; no auto sort, thx
 (setq cljr-auto-sort-ns nil)
 ;; no prefix notation, thx
 (setq cljr-favor-prefix-notation nil)
 ;; no multiple cursors
 (setq cljr-use-multiple-cursors nil)
 ;; some debug info ftw
 (setq cljr--debug-mode t)
 ;; use find usages even if stuff is broken
 (setq cljr-ignore-analyzer-errors t)
 ;; no network load on startup
 ;;(setq cljr-populate-artifact-cache-on-startup nil)
 ;; feel free to eval the project
 (setq cljr-warn-on-eval nil))

;; clojure related ends

;; nameless for elisp

(use-package
  nameless
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook #'nameless-mode)
  (setq nameless-discover-current-name nil);; no guessing
  (setq nameless-private-prefix t)
  (setq nameless-global-aliases '(("s" . "seq")
                                  ("c" . "cider")
                                  ("clj" . "clojure")
                                  ("r" . "cljr"))))

(use-package markdown-mode
  :ensure t
  :config
  (setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist))
  (setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist)))

(use-package org-mode
  :config
  (setq org-export-html-postamble nil)
  ;; Fontify org-mode code blocks
  (setq org-src-fontify-natively t)
  (setq org-todo-keywords
        '((sequence "TODO(t)" "|" "DONE(d)")
          (sequence "TODO(t)" "|" "READY(r)" "DONE(d)")
          (sequence "|" "CANCELLED(c)"))))

(use-package restclient
  :ensure t
  :config
  (setq restclient-same-buffer-response nil))

;;;;;
;; Go
;;;;;

(use-package go-mode
  :ensure t
  :config
  (setenv "GOPATH" "~/projects/go")
  (add-hook 'go-mode-hook 'auto-complete-for-go)
  (add-hook 'go-mode-hook
            (lambda ()
              (local-set-key (kbd "M-.") 'godef-jump) ; Godef jump key binding
              (local-set-key (kbd "M-*") 'pop-tag-mark))))

(use-package go-autocomplete
  :ensure t
  :config
  (add-hook 'go-mode-hook (lambda () (auto-complete-mode 1))))

;; Go ends here

(use-package disable-mouse
  :ensure t
  :config
  (global-disable-mouse-mode))
