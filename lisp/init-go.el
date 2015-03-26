(require-package 'go-mode)
(require-package 'go-eldoc)
(require-package 'helm-go-package)
(require-package 'company-go)

(add-hook 'go-mode-hook '(lambda ()
			   (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))

(add-hook 'go-mode-hook '(lambda ()
			   (local-set-key (kbd "C-c C-g") 'go-goto-imports)))

(add-hook 'go-mode-hook '(lambda ()
			   (local-set-key (kbd "C-c C-f") 'gofmt)))

(add-hook 'go-mode-hook '(lambda ()
			   (local-set-key (kbd "C-c C-k") 'godoc)))

(load "/home/madwind/Dropbox/madwind/golang/project/src/code.google.com/p/go.tools/cmd/oracle/oracle.el")
(add-hook 'go-mode-hook 'go-oracle-mode)


(add-to-list 'load-path "/home/madwind/Dropbox/madwind/golang/project/src/github.com/dougm/goflymake")
(require 'go-flymake)

(add-to-list 'load-path "/home/madwind/Dropbox/madwind/golang/project/src/github.com/dougm/goflymake")
(require 'go-flycheck)

;; (add-hook 'go-mode-hook (lambda ()
;;   (set (make-local-variable 'company-backends) '(company-go))
;;   (company-mode)))

(defun my-go-mode-hook ()
  ; Call Gofmt before saving
  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v -gcflags \"-N -l\" && go test -v && go vet"))
  ; Godef jump key binding
  ;; (local-set-key (kbd "M-.") 'godef-jump)
  ;; (setq-default) 
  ;; (setq tab-width 2) 
  ;; (setq standard-indent 2) 
  ;; (setq indent-tabs-mode nil)
  (set (make-local-variable 'company-backends) '(company-go))
  (company-mode))

(add-hook 'go-mode-hook 'my-go-mode-hook)

(add-hook 'before-save-hook 'gofmt-before-save)

(require 'go-eldoc)
(add-hook 'go-mode-hook 'go-eldoc-setup)

(autoload 'helm-go-package "helm-go-package") ;; Not necessary if using ELPA package
(eval-after-load 'go-mode
  '(substitute-key-definition 'go-import-add 'helm-go-package go-mode-map))

(provide 'init-go)
