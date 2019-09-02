(use-package lsp-mode
	     :ensure t
	     :commands lsp
	     :bind*
	     (:map lsp-mode
		   ("M-m" . lsp-describe-thing-at-point))
	     :init
	     (setq lsp-enable-xref t
		   lsp-enable-completion-at-point t
		   lsp-enable-eldoc nil
		   lsp-enable-symbol-highlighting nil
		   lsp-enable-codeaction nil
		   lsp-enable-indentation nil
		   lsp-enable-on-type-formatting nil
		   lsp-enable-links nil
		   lsp-enable-snippet nil
		   lsp-prefer-flymake :none
		   lsp-print-io nil
		   lsp-message-project-root-warning t)

	     (require 'lsp-clients)
	     (add-hook 'python-mode-hook 'lsp)

	     (use-package company-lsp
			  :ensure t
			  :commands company-lsp
			  :config
			  (push 'company-lsp company-backends)
			  (setq company-lsp-enable-recompletion t
				company-lsp-enable-snippet t)))


(setq lsp-restart 'auto-restart)
