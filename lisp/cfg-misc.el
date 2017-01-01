(defun toggle-maximized-with-font ()
  (interactive)
  (let ((fullscreenp (eq (frame-parameter nil 'fullscreen) 'maximized)))
    (if fullscreenp
        (set-face-attribute 'default nil :height 130)
      (set-face-attribute 'default nil :height 180)))
  (toggle-frame-maximized))

(global-set-key (kbd "C-x M-f") 'toggle-maximized-with-font)
