;; inf ruby
(add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)

;; company
(add-hook 'ruby-mode-hook 'company-mode)
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-inf-ruby))
