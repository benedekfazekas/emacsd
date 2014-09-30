;; complete with Control-tab
(global-set-key [C-tab] 'cider-repl-indent-and-complete-symbol)

;; cider result with nice prefix
(setq cider-repl-result-prefix "contemplate => ")

;; nicer font lock in repl
(setq cider-repl-use-clojure-font-lock t)

;; never ending history
(setq cider-repl-wrap-history t)

;; show port on remote repl
(setq nrepl-buffer-name-show-port t)

;; looong history
(setq cider-repl-history-size 3000)

(global-set-key (kbd "C-c n c") 'nrepl-close)
;; closes *all* REPLs
(global-set-key (kbd "C-c n q") 'cider-quit)

(global-set-key (kbd "M-p") 'cider-eval-print-last-sexp)
