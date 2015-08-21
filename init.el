;; ----------------------
;; Better dead than smeg.
;; ----------------------


;; Add .emacs.d to load-path
(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))
(add-to-list 'load-path dotfiles-dir)

;; speedbar config
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-tomorrow-eighties)))
 '(custom-safe-themes
   (quote
    ("628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default)))
 '(safe-local-variable-values
   (quote
    ((ffip-patterns "*.org" "*.rb" "*.sh" "*.md" "*.css" "*.scss" "Rakefile" "Procfile" "Capfile" "*.sql" "*.json" "*.haml" "*.js")
     (ffip-find-options . "-not -regex \".*out-.*\""))))
 '(speedbar-frame-parameters
   (quote
    ((minibuffer)
     (width . 33)
     (border-width . 0)
     (menu-bar-lines . 0)
     (tool-bar-lines . 0)
     (unsplittable . t)
     (left-fringe . 0))))
 '(speedbar-frame-plist
   (quote
    (minibuffer nil width 30 border-width 0 internal-border-width 0 unsplittable t default-toolbar-visible-p nil has-modeline-p nil menubar-visible-p nil default-gutter-visible-p nil)))
 '(speedbar-indentation-width 2)
 '(speedbar-show-unknown-files t)
 '(speedbar-use-images nil)
 '(xkcd-cache-dir "~/xkcd/")
 '(xkcd-cache-latest "~/xkcd/latest"))

(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
      (progn
        ;; use 120 char wide window for largeish displays
        ;; and smaller 80 column windows for smaller displays
        ;; pick whatever numbers make sense for you
        (if (> (x-display-pixel-width) 1280)
            (add-to-list 'default-frame-alist (cons 'width 121))
          (add-to-list 'default-frame-alist (cons 'width 81)))
        ;; for the height, subtract a couple hundred pixels
        ;; from the screen height (for panels, menubars and
        ;; whatnot), then divide by the height of a char to
        ;; get the height we want
        (add-to-list 'default-frame-alist
                     (cons 'height (/ (- (x-display-pixel-height) 10)
                                      (frame-char-height)))))))

;;(set-frame-size-according-to-resolution)

;; ELPA
(setq package-user-dir (concat dotfiles-dir "elpa"))
(require 'package)
(dolist (source '(("melpa" . "http://melpa.milkbox.net/packages/")
                  ("marmalade" . "http://marmalade-repo.org/packages/")
                  ("elpa" . "http://tromey.com/elpa/")))
  (add-to-list 'package-archives source t))
(package-initialize)

;; Sort out the $PATH for OSX
(require 'exec-path-from-shell)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; minimap
;;(add-to-list 'load-path (concat dotfiles-dir "/minimap"))
;;(require 'minimap)

(defun toggle-font-height ()
  (interactive)
  (let ((font-height (face-attribute 'default :height)))
    (if (= 130 font-height)
        (set-face-attribute 'default nil :height 180)
      (set-face-attribute 'default nil :height 130))))

;; Key Bindings
(global-set-key (kbd "<C-f11>") 'cider-jack-in)
(global-set-key (kbd "<f11>") 'ns-toggle-fullscreen)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key "\C-x\C-b" 'buffer-menu)
(global-set-key (kbd "ESC M-f") 'rgrep)
(global-set-key (kbd "<M-f11>") 'speedbar-get-focus)
;; current line ready for paste
(global-set-key "\C-c\C-w" "\C-a\C- \C-n\M-w")
;; duplicate current line
(global-set-key "\C-c\C-d" "\C-a\C- \C-n\M-w\C-y")
(global-set-key (kbd "M-j")
                (lambda ()
                  (interactive)
                  (join-line -1)))
(global-set-key (kbd "M-i") 'indent-buffer-sans-prettification)
(global-set-key (kbd "C-x M-f") 'toggle-font-height)

(setq backup-inhibited 'anyvaluebutnil )

;; C-c l/r to restore windows
(winner-mode 1)

;; undo-tree
(require 'undo-tree)
(global-undo-tree-mode)

;; Shows the kill ring
(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

;; expand region
(require 'expand-region)
(global-set-key (kbd "C-'") 'er/expand-region)

;; Minibuffer completion
;;(ido-mode)
;;(setq ido-enable-flex-matching t)
;;(setq global-auto-complete-mode t)


;; Parenthesis
(show-paren-mode)

;; rainbows
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; highlight symbols
(add-hook 'clojure-mode-hook 'idle-highlight-mode)
(add-hook 'emacs-lisp-mode 'idle-highlight-mode)

;; Paredit
(require 'paredit)
(add-hook 'lisp-mode-hook 'paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)

(setq cider-repl-history-file "~/.emacs.d/cider-history")
(setq cider-toggle-pretty-printing t)

;; eldoc
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

;; Markdown mode
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))

;; Clojure mode for ClojureScript
(add-to-list 'auto-mode-alist '("\.cljs$" . clojure-mode))

(require 'mustache-mode)
(add-to-list 'auto-mode-alist '("\.mustache$" . mustache-mode))

;; Dont like trailing whitespaces
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; set zk root
(setenv "CLJ_FE_ZK_ROOT" "clj-fe-ben")

(dolist (file '(
                "fb-autocomplete.el"
		"jp-ace-jump-mode.el"
                ;;		"jp-erc.el"
		"jp-multiple-cursors.el"
		"jp-html"
		"fb-cider"
		"fb-cljrefactor"
		"fb-org"
                "fb-ruby"
                ;;		"jp-nrepl"
		"jp-lnf.el"))
  (load (concat dotfiles-dir file)))

(global-auto-revert-mode t)
(put 'erase-buffer 'disabled nil)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; pretty symbols
(global-prettify-symbols-mode -1)

(add-hook 'clojure-mode-hook
          (lambda ()
            (push '(">=" .      ?≥) prettify-symbols-alist)
            (push '("<=" .      ?≤) prettify-symbols-alist)
            (push '("partial" . ?π) prettify-symbols-alist)
            (push '("defn" .    ?⇒) prettify-symbols-alist)
            (push '("defn-" .   ?⇛) prettify-symbols-alist)
            (push '("atom" .    ?α) prettify-symbols-alist)
            (push '("nil" .     ?Ø) prettify-symbols-alist)
            (push '("->" .      ?→) prettify-symbols-alist)
            (push '("->>" .     ?⇉) prettify-symbols-alist)
            (push '("reduce"    ?Σ) prettify-symbols-alist)
            (push '("map"       ?↦) prettify-symbols-alist)
            (push '("false"     ?ғ) prettify-symbols-alist)
            (push '("true"      ?τ) prettify-symbols-alist)
            (push '("or"        ?∨) prettify-symbols-alist)
            (push '("and"       ?∧) prettify-symbols-alist)
            (push '("not"       ?¬) prettify-symbols-alist)))

;; reformat buffer without prettify symbols
(defun indent-buffer-sans-prettification ()
  (interactive)
  (let ((pretty-on (-some? (lambda (mmode)
                             (and (boundp mmode) (symbol-value mmode) (string= "prettify-symbols-mode" (format "%s" mmode)))) minor-mode-list)))
    (when pretty-on
      (prettify-symbols-mode -1))
    (save-excursion
      (indent-region (point-min) (point-max) nil)
      (save-buffer))
    (when pretty-on
      (prettify-symbols-mode +1))))

;;(set-variable 'magit-emacsclient-executable "/usr/bin/emacsclient")

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:slant normal :weight demibold))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "selectedMenuItemColor"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "Yellow"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "Green"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "Orange"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "Magenta"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "Brown"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "Purple"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "White"))))
 '(rainbow-delimiters-unmatched-face ((t (:foreground "Red")))))

(setq-default indent-tabs-mode nil)

(setq split-width-threshold 120)

(setq org-todo-keywords
           '((sequence "TODO(t)" "|" "DONE(d)")
             (sequence "TODO(t)" "|" "READY(r)" "DONE(d)")
             (sequence "|" "CANCELED(c)")))

;; start the day nicely
(require 'xkcd)
(add-hook 'emacs-startup-hook 'xkcd-get-latest)
