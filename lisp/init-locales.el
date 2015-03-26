(defun sanityinc/utf8-locale-p (v)
  "Return whether locale string V relates to a UTF-8 locale."
  (and v (string-match "UTF-8" v)))

(defun locale-is-utf8-p ()
  "Return t iff the \"locale\" command or environment variables prefer UTF-8."
  (or (sanityinc/utf8-locale-p (and (executable-find "locale") (shell-command-to-string "locale")))
      (sanityinc/utf8-locale-p (getenv "LC_ALL"))
      (sanityinc/utf8-locale-p (getenv "LC_CTYPE"))
      (sanityinc/utf8-locale-p (getenv "LANG"))))

(when (or window-system (locale-is-utf8-p))
  (setq utf-translate-cjk-mode nil) ; disable CJK coding/encoding (Chinese/Japanese/Korean characters)
  (set-language-environment 'utf-8)
  (setq locale-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-selection-coding-system (if (eq system-type 'windows-nt) 'utf-16-le 'utf-8))
  (prefer-coding-system 'utf-8))

(require-package 'google-translate)
(global-set-key "\C-ct" 'google-translate-at-point)
(global-set-key "\C-cT" 'google-translate-query-translate)
(setq google-translate-default-source-language "en"
      google-translate-default-target-language "ko")

;; flymake 에러 코드 표시 단축키 설정
(defun my-flymake-show-error ()
  "Display flymake message from current line."
  (interactive)
  (flymake-display-err-menu-for-current-line))
(global-set-key [?\C-`] 'my-flymake-show-error)

;; My Setting
(global-set-key [f1] 'compile)
(global-set-key [f2] 'next-error)

;turn on Semantic
(semantic-mode 1)


(require-package 'yasnippet)
(yas-global-mode 1)
(define-key yas-minor-mode-map (kbd "C-c k") 'yas-expand)

(setq make-backup-files nil)


(defun my-insert-line ()
  "Insert blank line below the cursor."
  (interactive)
  (end-of-line)
  (newline-and-indent))

(global-set-key "\M-o" 'my-insert-line);


;; 반 투명
(defun opaque-frame ()
  (set-frame-parameter nil 'alpha '(100 100))
  (set-foreground-color "ghost white")
  (set-background-color "black")
)

(defun transparent-frame()
  (set-frame-parameter nil 'alpha '(70 60))
  (set-foreground-color "black")
  (set-background-color "ghost white")
)

(set-frame-parameter (selected-frame) 'alpha '(100 100))
(add-to-list 'default-frame-alist '(alpha 100 100))
(defun toggle-transparency ()
   (interactive)
   (if (/=
        (cadr (find 'alpha (frame-parameters nil) :key #'car))
        100)
       (opaque-frame)
       ;(set-frame-parameter nil 'alpha '(100 100))
     ;(set-frame-parameter nil 'alpha '(85 60))
     (transparent-frame)
      ;(set-foreground-color . "black")
      ;(set-foreground-color . "white"))
     ))

(provide 'init-locales)
