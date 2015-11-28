(require 'clj-refactor)
(add-hook 'clojure-mode-hook
	  (lambda ()
	    (clj-refactor-mode 1)
	    ;; insert keybinding setup here
	    (cljr-add-keybindings-with-prefix "C-c")))

(add-hook 'clojure-mode-hook (lambda () (yas/minor-mode 1)))

;; uses semantic comparator
(setq cljr-sort-comparator 'cljr--semantic-comparator)

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
