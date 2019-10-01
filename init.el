(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(column-number-mode t)
 '(custom-enabled-themes (quote (tango-dark)))
 '(custom-safe-themes
   (quote
    ("8eafb06bf98f69bfb86f0bfcbe773b44b465d234d4b95ed7fa882c99d365ebfd" default)))
 '(ede-project-directories (quote ("/storage/git/stk")))
 '(global-display-line-numbers-mode t)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (cmake-font-lock helm-swoop helm-ag clang-format+ blacken dashboard sr-speedbar folding py-autopep8 treemacs-projectile treemacs helm cmake-project cmake-mode cmake-ide lsp-ui company-lsp lsp-mode load-dir fill-column-indicator smooth-scrolling system-packages)))
 '(scroll-bar-mode nil)
 '(scroll-conservatively 10000)
 '(smooth-scroll-mode t)
 '(smooth-scroll/vscroll-step-size 1)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "ADBO" :slant normal :weight normal :height 102 :width normal)))))

(setq make-backup-files nil)
(setq-default cursor-type 'bar)

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;; (require 'smooth-scroll)
;; (smooth-scroll-mode t)

(setq initial-scratch-message "")

(global-set-key (kbd "C-x C-b") 'buffer-menu)
(global-set-key (kbd "C-S-s") 'helm-swoop)
(global-set-key (kbd "C-S-x C-S-f") 'helm-do-ag)

(setq-default fill-column 80)
(setq fci-rule-width 1)
(setq fci-rule-color "darkblue")

(define-globalized-minor-mode global-fci-mode fci-mode
  (lambda() (fci-mode 1)))
(global-fci-mode 1)

(require 'helm-config)
(helm-mode 1)

(load "~/.emacs.d/custom")
(load "~/.emacs.d/lsp/python")
(load "~/.emacs.d/lsp/cquery")

(defun my/clang-format-buffer (&rest _)
  (when (or (eq major-mode 'c-mode)
	    (eq major-mode 'c++-mode))
      (clang-format-buffer _)))

(defun my/add-clang-format-buffer-before-save-hook ()
  (add-hook 'before-save-hook
	    'my/clang-format-buffer))

(add-hook 'c-mode-common-hook 'my/add-clang-format-buffer-before-save-hook)
(add-hook 'c++-mode-common-hook 'my/add-clang-format-buffer-before-save-hook)

(global-display-line-numbers-mode)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(global-auto-revert-mode 't)
(recentf-mode 1)

(add-hook 'python-mode-hook 'blacken-mode)
