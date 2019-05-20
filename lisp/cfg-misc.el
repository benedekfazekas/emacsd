(defun bf-toggle-maximized-with-font ()
  (interactive)
  (let ((fullscreenp (eq (frame-parameter nil 'fullscreen) 'maximized)))
    (if fullscreenp
        (set-face-attribute 'default nil :height 130)
      (set-face-attribute 'default nil :height 180)))
  (toggle-frame-maximized))

(global-set-key (kbd "C-x M-f") 'bf-toggle-maximized-with-font)
(display-pixel-width)
(defun bf--maxframe ()
  (if (> (display-pixel-width) 1440)
      (bf-toggle-maximized-with-font)
    (toggle-frame-maximized)))

(add-hook 'emacs-startup-hook 'bf--maxframe)
