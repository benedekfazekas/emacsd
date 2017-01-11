;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;; disable the annoying bell ring
(setq ring-bell-function 'ignore)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)

;; todo: nick bbatsov's
(setq frame-title-format "%b")
(setq inhibit-splash-screen t)
(set-face-attribute 'default nil :height 130)

;; Scrolling
(setq scroll-step 1)

;; show time
;;(setq display-time-24hr-format t)
;;(setq display-time-load-average t)
;;(display-time)

;; show column number
(column-number-mode t)

;; y/n hassle
(fset 'yes-or-no-p 'y-or-n-p)

;; set a nice split window threshold
(setq split-width-threshold 130)

;; go on, prettify
(global-prettify-symbols-mode 1)

;; Parenthesis
(show-paren-mode)

;; Dont like trailing whitespaces
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; load sql creds from home
(load "~/sqldefs.el")

;; no indent with tabs
(setq-default indent-tabs-mode nil)

;; comment/uncomment sexp (Malabarba)
(load (concat cfgfiles-lisp-dir "sotlisp.el"))

;;(setq backup-inhibited 'anyvaluebutnil )

;; custom keys
(global-set-key (kbd "ESC M-f") 'rgrep)
(global-set-key
 (kbd "M-j")
 (lambda ()
   (interactive)
   (join-line -1)))

;; Auto refresh buffers
(global-auto-revert-mode 1)

;; Show keystrokes in progress
(setq echo-keystrokes 0.1)

;; Transparently open compressed files
(auto-compression-mode t)

;; Lines should be 80 characters wide, not 72
(setq fill-column 80)

;; Save a list of recent files visited. (open recent file with C-x f)
(recentf-mode 1)
(setq recentf-max-saved-items 50) ;; just 20 is too recent

;; Show me empty lines after buffer end
(set-default 'indicate-empty-lines t)

;; Easily navigate sillycased words
(global-subword-mode 1)

;; Offer to create parent directories if they do not exist
;; http://iqbalansari.github.io/blog/2014/12/07/automatically-create-parent-directories-on-visiting-a-new-file-in-emacs/
(defun my-create-non-existent-directory ()
  (let ((parent-directory (file-name-directory buffer-file-name)))
    (when (and (not (file-exists-p parent-directory))
               (y-or-n-p (format "Directory `%s' does not exist! Create it?" parent-directory)))
      (make-directory parent-directory t))))

(add-to-list 'find-file-not-found-functions 'my-create-non-existent-directory)
