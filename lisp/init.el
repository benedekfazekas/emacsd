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
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#eaeaea" "#d54e53" "#b9ca4a" "#e7c547" "#7aa6da" "#c397d8" "#70c0b1" "#000000"))
 '(custom-enabled-themes (quote (sanityinc-tomorrow-eighties)))
 '(custom-safe-themes
   (quote
    ("4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default)))
 '(fci-rule-color "#2a2a2a")
 '(neo-theme (quote ascii))
 '(safe-local-variable-values
   (quote
    ((nameless-current-name . cljr)
     (checkdoc-package-keywords-flag)
     (clojure-defun-style-default-indent . t)
     (bug-reference-bug-regexp . "#\\(?2:[[:digit:]]+\\)")
     (ffip-patterns "*.org" "*.rb" "*.sh" "*.md" "*.css" "*.scss" "Rakefile" "Procfile" "Capfile" "*.sql" "*.json" "*.haml" "*.js")
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
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#d54e53")
     (40 . "#e78c45")
     (60 . "#e7c547")
     (80 . "#b9ca4a")
     (100 . "#70c0b1")
     (120 . "#7aa6da")
     (140 . "#c397d8")
     (160 . "#d54e53")
     (180 . "#e78c45")
     (200 . "#e7c547")
     (220 . "#b9ca4a")
     (240 . "#70c0b1")
     (260 . "#7aa6da")
     (280 . "#c397d8")
     (300 . "#d54e53")
     (320 . "#e78c45")
     (340 . "#e7c547")
     (360 . "#b9ca4a"))))
 '(vc-annotate-very-old-color nil)
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
(dolist (source '(
                  ;;("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
                  ("melpa" . "http://melpa.milkbox.net/packages/")
                  (";marmalade" . "http://marmalade-repo.org/packages/")
                  ("elpa" . "http://tromey.com/elpa/")
                  ))
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
        (progn
          (set-face-attribute 'default nil :height 180)
          (toggle-frame-maximized))
      (set-face-attribute 'default nil :height 130)
      (toggle-frame-maximized))))

(require 'neotree)
;; neotree
(global-set-key [f8] 'neotree-toggle)
(setq neo-smart-open t)
(setq neo-show-hidden-files t)
(add-hook
 'buffer-list-update-hook
 (lambda ()
   (let ((buffer-path (buffer-file-name)))
     (when (and (neo-global--window-exists-p)
                (not (boundp 'neotree-in-update))
                buffer-path
                (s-contains? "benedek.fazekas/projects/" buffer-path)
                (not (s-contains? "benedek.fazekas/projects/tmp" buffer-path)))
       (let ((neotree-in-update t)
             (new-root-dir (s-join "" (-take 4 (s-slice-at "/" buffer-path)))))
         (when (not (neo-global--file-in-root-p new-root-dir))
           (save-selected-window
             (neotree-dir new-root-dir)))
         (when
             (not (string=
                   buffer-path
                   (neo-global--with-buffer (neo-buffer--get-filename-current-line))))
           (save-selected-window
             (neotree-show))))))))



;; Key Bindings
(global-set-key (kbd "<C-f11>") 'cider-jack-in)
(global-set-key (kbd "<f11>") 'ns-toggle-fullscreen)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key "\C-x\C-b" 'buffer-menu)
(global-set-key (kbd "ESC M-f") 'rgrep)
;;(global-set-key (kbd "<M-f11>") 'speedbar-get-focus)
;; current line ready for paste
(global-set-key "\C-c\C-w" "\C-a\C- \C-n\M-w")
;; duplicate current line
(global-set-key "\C-c\C-d" "\C-a\C- \C-n\M-w\C-y")
(global-set-key (kbd "M-j")
                (lambda ()
                  (interactive)
                  (join-line -1)))
;;(global-set-key (kbd "M-i") 'indent-buffer-sans-prettification)
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
(add-hook 'cider-mode-hook #'eldoc-mode)

;; nameless mode
(add-hook 'emacs-lisp-mode-hook #'nameless-mode)
(setq nameless-discover-current-name nil);; no guessing
(setq nameless-private-prefix t)
(setq nameless-global-aliases '(("s" . "seq")
                                ("c" . "cider")
                                ("clj" . "clojure")
                                ("r" . "cljr")))

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
;;(setenv "CLJ_FE_ZK_ROOT" "clj-fe-ben")

(dolist (file '(
                "fb-autocomplete.el"
		"jp-ace-jump-mode.el"
                "aws.el"
                ;;		"jp-erc.el"
		"jp-multiple-cursors.el"
		"jp-html"
		"fb-cider"
		"fb-cljrefactor"
		"fb-org"
                "fb-ruby"
                "fb-sotlisp"
                ;;		"jp-nrepl"
		"jp-lnf.el"))
  (load (concat dotfiles-dir file)))

(load "~/sqldefs.el")

(global-set-key (kbd "C-x M-a") 'aws-authenticate)

(global-auto-revert-mode t)
(put 'erase-buffer 'disabled nil)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; nice font with ligatures
(when (window-system)
  (set-default-font "Fira Code"))

(mac-auto-operator-composition-mode)
;; |>=>
;; |>=>>

(global-prettify-symbols-mode 1)

(add-hook 'clojure-mode-hook
          (lambda ()
            (push '("fn" .    (?· (Br . Bl) ?λ)) prettify-symbols-alist)
            ;;(push '("defn" .  (?= (Br . Bc) ?= (Br . Bc) ?= (Br . Bc) ?= (Br . Bc) ?= (Br . Bc) ?= (Br . Bc) ?= (Br . Bc) ?= (Br . Bc) ?>)) prettify-symbols-alist)
            ;;(push '("defn-" . (?· (Br . Bl) ?= (Br . Bc) ?= (Br . Bc) ?= (Br . Bc) ?> (Br . Bc) ?>)) prettify-symbols-alist)
            ;;(push '("map" .   (?~ (Br . Bc) ?~ (Br . Bc) ?~ (Br . Bc) ?~ (Br . Bc) ?~ (Br . Bc) ?>)) prettify-symbols-alist)
            ;;(push '("atom" .  (?] (Br . Bl) ?} (Br . Bl) ?) (Br . Bl) ?⚛ (Br . Bl) ?( (Br . Bl) ?{ (Br . Bl) ?[)) prettify-symbols-alist)

            )
          )


(sml/setup)
(add-to-list 'sml/replacer-regexp-list '("^~/Downloads/" ":Dwn:") t)
(add-to-list 'sml/replacer-regexp-list '("^~/projects/tmp/" ":projtmp:") t)
(add-to-list 'sml/replacer-regexp-list '("^~/projects/" ":proj:") t)
(add-to-list 'sml/replacer-regexp-list '("^/tmp/" ":TMP:") t)


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
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

(eval-after-load 'company-etags
  '(progn
     (add-to-list 'company-etags-modes 'js2-mode)))

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(add-hook 'after-init-hook 'global-company-mode)

(setq split-width-threshold 120)

(setq org-todo-keywords
           '((sequence "TODO(t)" "|" "DONE(d)")
             (sequence "TODO(t)" "|" "READY(r)" "DONE(d)")
             (sequence "|" "CANCELLED(c)")))

;; start the day nicely
(require 'xkcd)
(add-hook 'emacs-startup-hook 'xkcd-get-latest)
