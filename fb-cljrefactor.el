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

(setq cljr-favor-prefix-notation nil)
