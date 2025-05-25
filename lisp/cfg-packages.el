(use-package
 magit
 :ensure t
 ;;:pin melpa-stable
 :bind ("C-x g" . magit-status)
 :config
 (defun bf/magit-cursor-fix ()
   (beginning-of-buffer)
   (when (looking-at "#")
     (forward-line 2)))
 (set-default 'magit-revert-buffers 'silent)
 (set-default 'magit-no-confirm '(stage-all-changes unstage-all-changes))
 (add-hook 'git-commit-mode-hook 'bf/magit-cursor-fix))

;; (use-package gh
;;   :ensure t
;;   :after magit)

(use-package
 paredit
 :ensure t
 ;;:pin melpa-stable
 :bind ("C-M-g" . paredit-forward-down)
 :config
 (add-hook 'lisp-mode-hook 'paredit-mode)
 (add-hook 'emacs-lisp-mode-hook 'paredit-mode))

(use-package
 rainbow-delimiters
 :ensure t
 ;;:pin melpa-stable
 :config
 (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package
 yasnippet
 :ensure t
 ;;:pin melpa-stable
 )

(use-package
 smart-mode-line
 :ensure t
 ;;:pin melpa-stable
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
  ;;:pin melpa-stable
  :config
  (add-hook 'emacs-startup-hook 'xkcd-get-latest))

(use-package uniquify
  ;; make duplicate buffer names unique
  :config
  (setq uniquify-buffer-name-style 'forward))

(use-package
  web-mode
  :ensure t
  ;;:pin melpa-stable
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
  ;;:pin melpa-stable
  )

;;;;;;;;;;;;;;;;;;;;;;
;; unstable packages
;;;;;;;;;;;;;;;;;;;;;;

(use-package auto-complete
  ;;:ensure t
  :disabled
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
 ;; :pin melpa-stable
 :ensure t
 :config
 (setq clojure-align-forms-automatically nil)
 (add-hook 'clojure-mode-hook 'paredit-mode)
 (add-hook 'clojure-mode-hook 'bf/fancify-symbols))

(use-package
  inf-clojure
  :disabled
  :ensure t)

(use-package
  parseedn
  :ensure t)

(use-package
 cider
 ;;:pin melpa-stable
 ;; :load-path "~/projects/cider/"
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
 ;; log nrepl messages
 ;(setq nrepl-log-messages t)
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
 ;(add-hook 'cider-mode-hook 'company-mode)
 )

(use-package
 clj-refactor
 :disabled
 :ensure t
 :config
 ;; make sure seq version is newer than built in
 ;(require 'seq-25)
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

(use-package
  sayid
  ;:ensure t
  :disabled
  :config
  ;; (eval-after-load 'clojure-mode
  ;;  '(sayid-setup-package))
  )

;; clojure-lsp
(use-package lsp-mode
  :ensure t
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook ((clojure-mode . lsp)
         (clojurec-mode . lsp)
         (clojurescript-mode . lsp)
         ((tsx-ts-mode typescript-ts-mode js-ts-mode) . lsp)
         )
  :config
  (dolist (m '(clojure-mode
               clojurec-mode
               clojurescript-mode
               clojurex-mode))
    (add-to-list 'lsp-language-id-configuration `(,m . "clojure")))
  ;;(setq lsp-enable-indentation nil)
  ;; (setq lsp-lens-enable t);; shows count of references atm, slow
  )

;; (use-package lsp-java
;;   :ensure t
;;   :after lsp
;;   :config (add-hook 'java-mode-hook 'lsp))

(use-package lsp-ui
  ;;:ensure t
  :disabled
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-sideline-show-code-actions nil
        lsp-ui-peek-enable nil))

(use-package company-lsp
  :ensure t
  :commands company-lsp)

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

(use-package org
  :defer t
  :ensure t
  :config
  (setq org-export-html-postamble nil)
  ;; Fontify org-mode code blocks
  (setq org-src-fontify-natively t)
  (setq org-todo-keywords
        '((sequence "TODO(t)" "|" "READY(r)" "DONE(d)")
          (sequence "|" "CANCELLED(c)"))))

;;org-use-fast-todo-selection
;; (use-package restclient
;;   :ensure t
;;   :config
;;   (setq restclient-same-buffer-response nil))

;;;;;
;; Go
;;;;;

(use-package go-mode
  :ensure t
  :config
  (setenv "GOPATH" "~/go")
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

;;;;;;;
;; Ruby
;;;;;;;

(use-package robe
  :ensure t
  :config
  (add-hook 'ruby-mode-hook 'robe-mode))

(use-package yaml-mode
  :ensure t)

(use-package snake-mode
  :disabled
  :load-path "~/projects/snake-mode")

(use-package package-lint
  :ensure t)

(use-package flycheck-joker
  :disabled
  :ensure t)

(use-package speed-type
  :ensure t)

;; (use-package pgyn-mode
;;   :ensure t
;;   :bind (("C-c M-f" . pygn-mode-next-move-follow-board)
;;          ("C-c M-b" . pygn-mode-previous-move-follow-board)
;;          ("C-c M-c" . pygn-mode-display-gui-board-at-pos)
;;          ("C-c M-a" . pygn-mode-describe-annotation-at-pos)))

(use-package chess
  :disabled
  :ensure t)

;; This is an Emacs package that creates graphviz directed graphs from
;; the headings of an org file
(use-package org-mind-map
  :disabled
  :init
  (require 'ox-org)
  :ensure t
  ;; Uncomment the below if 'ensure-system-packages` is installed
  ;;:ensure-system-package (gvgen . graphviz)
  :config
  (setq org-mind-map-engine "dot")       ; Default. Directed Graph
  ;; (setq org-mind-map-engine "neato")  ; Undirected Spring Graph
  ;; (setq org-mind-map-engine "twopi")  ; Radial Layout
  ;; (setq org-mind-map-engine "fdp")    ; Undirected Spring Force-Directed
  ;; (setq org-mind-map-engine "sfdp")   ; Multiscale version of fdp for the layout of large graphs
  ;; (setq org-mind-map-engine "twopi")  ; Radial layouts
  ;; (setq org-mind-map-engine "circo")  ; Circular Layout
  )

(use-package restclient
  :ensure t)

(use-package gptel
  :disabled
  :ensure t
  :config
  (setq
   gptel-model "gemini-pro"
   gptel-backend (gptel-make-gemini "Gemini"
                                    :key 'gemini-api-key
                                    :stream t)))

(use-package eglot
  :ensure t)

(use-package kotlin-mode
  :after (lsp-mode)
  :ensure t
  :config
  ;; (require 'dap-kotlin)
  ;; should probably have been in dap-kotlin instead of lsp-kotlin
  ;; (setq lsp-kotlin-debug-adapter-path (or (executable-find "kotlin-debug-adapter") ""))
  :hook (kotlin-mode . lsp))

(use-package tide
  :ensure t)

(use-package treesit
  :mode (("\\.tsx\\'" . tsx-ts-mode)
         ("\\.js\\'"  . typescript-ts-mode)
         ("\\.mjs\\'" . typescript-ts-mode)
         ("\\.mts\\'" . typescript-ts-mode)
         ("\\.cjs\\'" . typescript-ts-mode)
         ("\\.ts\\'"  . typescript-ts-mode)
         ("\\.jsx\\'" . tsx-ts-mode)
         )
  :preface
  (defun os/setup-install-grammars ()
    "Install Tree-sitter grammars if they are absent."
    (interactive)
    (dolist (grammar
             '((css . ("https://github.com/tree-sitter/tree-sitter-css" "v0.20.0"))
               (html . ("https://github.com/tree-sitter/tree-sitter-html" "v0.20.1"))
               (javascript . ("https://github.com/tree-sitter/tree-sitter-javascript" "v0.21.2" "src"))
               (tsx . ("https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.3" "tsx/src"))
               (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.3" "typescript/src"))))
      (add-to-list 'treesit-language-source-alist grammar)
      ;; Only install `grammar' if we don't already have it
      ;; installed. However, if you want to *update* a grammar then
      ;; this obviously prevents that from happening.
      (unless (treesit-language-available-p (car grammar))
        (treesit-install-language-grammar (car grammar)))))

  ;; Optional, but recommended. Tree-sitter enabled major modes are
  ;; distinct from their ordinary counterparts.
  ;;
  ;; You can remap major modes with `major-mode-remap-alist'. Note
  ;; that this does *not* extend to hooks! Make sure you migrate them
  ;; also
  (dolist (mapping
           '((css-mode . css-ts-mode)
             (typescript-mode . typescript-ts-mode)
             (js-mode . typescript-ts-mode)
             (js2-mode . typescript-ts-mode)
             (css-mode . css-ts-mode)))
    (add-to-list 'major-mode-remap-alist mapping))
  :config
  (os/setup-install-grammars))

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; if you use treesitter based typescript-ts-mode (emacs 29+)
(add-hook 'typescript-ts-mode-hook #'setup-tide-mode)
