;; unstable packages

;;;;;;;;;;;;;;
;; Clojure
;;;;;;;;;;;;;;

(use-package
 clojure-mode
 :ensure t
 :config
 (add-hook 'clojure-mode-hook 'paredit-mode)
 (add-hook 'clojure-mode-hook
          (lambda ()
            (push '("fn" . (?· (Br . Bl) ?λ)) prettify-symbols-alist))))

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
