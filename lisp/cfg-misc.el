(defun toggle-maximized-with-font ()
  (interactive)
  (let ((fullscreenp (eq (frame-parameter nil 'fullscreen) 'maximized)))
    (if fullscreenp
        (set-face-attribute 'default nil :height 130)
      (set-face-attribute 'default nil :height 180)))
  (toggle-frame-maximized))

(global-set-key (kbd "C-x M-f") 'toggle-maximized-with-font)

(defun bf--maxframe ()
  (if (> (display-pixel-width) 1280)
      (toggle-maximized-with-font)
    (toggle-frame-maximized)))

(add-hook 'emacs-startup-hook 'bf--maxframe)