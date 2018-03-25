(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.packages/"))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-always-ensure t)
(eval-when-compile
  (require 'use-package))

(setq shell-file-name "/bin/bash")

(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  (setq evil-want-abbrev-expand-on-insert-exit nil)
  :config
  (evil-mode 1))
(use-package company
  :init (add-hook 'after-init-hook 'global-company-mode))
(use-package company-coq
  :config (add-hook 'coq-mode-hook #'company-coq-initialize))
(load "~/.emacs.d/lisp/PG/generic/proof-site")
;;(load "~/.emacs.d/lisp/color-theme-wombat.el")
(load-theme 'wombat' t)
(setq proof-splash-seen t)
(setq proof-three-window-mode-policy 'hybrid)
(setq proof-script-fly-past-comments t)

(evil-define-key 'normal coq-mode-map (kbd "SPC") #'proof-goto-point)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (evil use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
