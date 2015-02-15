;; inf ruby
(add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)

;;yasnippet
(add-hook 'ruby-mode-hook 'yas-minor-mode)
(add-hook 'ruby-mode-hook 'yas-reload-all)

;; company
(add-hook 'ruby-mode-hook 'company-mode)
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-inf-ruby))
