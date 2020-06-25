;; newline-without-break-of-line
(defun newline-without-break-of-line ()
  "1. move to end of the line.
  2. insert newline with index"

  (interactive)
  (let ((oldpos (point)))
    (end-of-line)
    (newline-and-indent)))

(global-set-key (kbd "<C-return>") 'newline-without-break-of-line)

(setq show-paren-delay 0)
(show-paren-mode 1)

(setq inhibit-startup-message t)
(fset 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "<f5>") 'revert-buffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(global-linum-mode t)

(delete-selection-mode 1)

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config (which-key-mode))

(setq org-hide-leading-stars t)

(defadvice org-babel-execute-src-block (around load-language nil activate)
  "Load language if needed"
  (let ((language (org-element-property :language (org-element-at-point))))
    (unless (cdr (assoc (intern language) org-babel-load-languages))
      (add-to-list 'org-babel-load-languages (cons (intern language) t))
      (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages))
    ad-do-it))

(defun my-org-confirm-babel-evaluate (lang body)
  (not (string= lang "python")))  ; don't ask for python
(setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)

(use-package ace-window
  :ensure t
  :init
(progn
  (global-set-key [remap other-window] 'ace-window)
  (custom-set-faces
   '(aw-leading-char-face
     ((t (:inherit ace-jump-face-foreground :height 3.0)))))
  ))

(use-package counsel
  :ensure t
  :bind
  (("M-y" . counsel-yank-pop)
  :map ivy-minibuffer-map
  ("M-y" . ivy-next-line)
  ))

(use-package swiper
  :ensure t
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq enable-recursive-minibuffers t)
    (global-set-key "\C-s" 'swiper)
    (global-set-key (kbd "C-c C-r") 'ivy-resume)
    (global-set-key (kbd "<f6>") 'ivy-resume)
    (global-set-key (kbd "M-x") 'counsel-M-x)
    (global-set-key (kbd "C-x C-f") 'counsel-find-file)
    (global-set-key (kbd "<f1> f") 'counsel-describe-function)
    (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
    (global-set-key (kbd "<f1> l") 'counsel-find-library)
    (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
    (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
    (global-set-key (kbd "C-c g") 'counsel-git)
    (global-set-key (kbd "C-c j") 'counsel-git-grep)
    (global-set-key (kbd "C-c k") 'counsel-ag)
    (global-set-key (kbd "C-x l") 'counsel-locate)
    (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
    ))

(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))
(setq shift-select-mode nil) ;; When you expand region then C-g for some reason has conflict with transient-mark-mode

(use-package iedit
  :ensure t)

(define-prefix-command 'endless/toggle-map)
;; The manual recommends C-c for user keys, but C-x t is
;; always free, whereas C-c t is used by some modes.
(define-key ctl-x-map "t" 'endless/toggle-map)
(define-key endless/toggle-map "c" #'column-number-mode)
(define-key endless/toggle-map "d" #'toggle-debug-on-error)
(define-key endless/toggle-map "e" #'toggle-debug-on-error)
(define-key endless/toggle-map "f" #'auto-fill-mode)
(define-key endless/toggle-map "l" #'toggle-truncate-lines)
(define-key endless/toggle-map "q" #'toggle-debug-on-quit)
(define-key endless/toggle-map "t" #'endless/toggle-theme)
;;; Generalized version of `read-only-mode'.
(define-key endless/toggle-map "r" #'dired-toggle-read-only)
(autoload 'dired-toggle-read-only "dired" nil t)
(define-key endless/toggle-map "w" #'whitespace-mode)

(defun narrow-or-widen-dwim (p)
  "Widen if buffer is narrowed, narrow-dwim otherwise.
Dwim means: region, org-src-block, org-subtree, or
defun, whichever applies first. Narrowing to
org-src-block actually calls `org-edit-src-code'.

With prefix P, don't widen, just narrow even if buffer
is already narrowed."
  (interactive "P")
  (declare (interactive-only))
  (cond ((and (buffer-narrowed-p) (not p)) (widen))
        ((region-active-p)
         (narrow-to-region (region-beginning)
                           (region-end)))
        ((derived-mode-p 'org-mode)
         ;; `org-edit-src-code' is not a real narrowing
         ;; command. Remove this first conditional if
         ;; you don't want it.
         (cond ((ignore-errors (org-edit-src-code) t)
                (delete-other-windows))
    	   ((ignore-errors (org-narrow-to-block) t))
    	   (t (org-narrow-to-subtree))))
        ((derived-mode-p 'latex-mode)
         (LaTeX-narrow-to-environment))
        (t (narrow-to-defun))))

(define-key endless/toggle-map "n"
  #'narrow-or-widen-dwim)
;; This line actually replaces Emacs' entire narrowing
;; keymap, that's how much I like this command. Only
;; copy it if that's what you want.
(define-key ctl-x-map "n" #'narrow-or-widen-dwim)
(add-hook 'LaTeX-mode-hook
          (lambda ()
            (define-key LaTeX-mode-map "\C-xn"
    	  nil)))

(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)
    (add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
    ))

;; (use-package color-theme
;;   :ensure t)

;; (use-package zenburn-theme
;;   :ensure t
;;   :config (load-theme 'zenburn t))

;; (use-package monokai-theme
;;   :ensure t
;;   :config (load-theme 'monokai t))

;; (use-package ample-theme
;;   :init (progn (load-theme 'ample t t)
;;     	     (load-theme 'ample-flat t t)
;;     	     (load-theme 'ample-light t t)
;;     	     (enable-theme 'ample))
;;   :defer t
;;   :ensure t

;; (use-package atom-one-dark-theme
;;   :ensure t
;;   :config (load-theme 'atom-one-dark t))

;; (use-package tangotango-theme
;;   :ensure t
;;   :config (load-theme 'tangotango t))
(load-theme 'atom-one-dark t)

(setq org-reveal-mathjax t)
(use-package ox-reveal
  :ensure ox-reveal)
(setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/"
   )

(use-package smartparens
  :ensure t
  :config (require 'smartparens-config)
  :init (smartparens-global-mode t))

(setenv "PATH"
	(concat
	 "C:/Users/chanyoungs/Anaconda2/Scripts/" ";"
	 (getenv "PATH")
	 )
	)

(setq python-shell-completion-native-enable nil)
;; (setq python-shell-prompt-detect-failure-warning nil)

;; (with-eval-after-load 'python
;;   (defun python-shell-completion-native-try ()
;;     "Return non-nil if can trigger native completion."
;;     (let ((python-shell-completion-native-enable t)
;;        (python-shell-completion-native-output-timeout
;;    	python-shell-completion-native-try-output-timeout))
;;    (python-shell-completion-native-get-completions
;;     (get-buffer-process (current-buffer))
;;     nil "_"))))

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

(use-package jedi
  :ensure t
  :init
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-hook 'python-mode-hook 'jedi:ac-setup))
  ;; (remove-hook 'python-mode-hook 'ac-modes)

(use-package exec-path-from-shell
  :ensure t)

(use-package projectile
  :ensure    projectile
  :config    (projectile-global-mode t)
  :diminish   projectile-mode)

(use-package epc
  :ensure t)

(use-package elpy
  :ensure t
  :config
  (elpy-enable))

(use-package ein
  :ensure t)

;; ;;; my hack to calls ein:notebook-save-notebook-command when in ein mode
;; (defun save-buffer (&optional arg)
;;   (interactive "p")
;;   (if (eq major-mode 'ein:notebook-multilang-mode)
;;       (ein:notebook-save-notebook-command)
;;     (let ((modp (buffer-modified-p))
;; 	  (make-backup-files (or (and make-backup-files (not (eq arg 0)))
;; 				 (memq arg '(16 64)))))
;;       (and modp (memq arg '(16 64)) (setq buffer-backed-up nil))
;;       (if (and modp (buffer-file-name))
;; 	  (message "Saving file %s..." (buffer-file-name)))
;;       (basic-save-buffer)
;;       (and modp (memq arg '(4 64)) (setq buffer-backed-up nil)))))

;; ;;; advice /defadvice that fails
;; (defun save-ein()
;;   (if (eq major-mode 'ein:notebook-multilang-mode)
;;       (ein:notebook-save-notebook-command))))
;; (advice-add 'save-buffer :before #'save-ein)

(use-package conda
  :ensure t)
(custom-set-variables
 '(conda-anaconda-home "C:/Users/chanyoungs/Anaconda2"))

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1)
  )

(use-package auto-yasnippet
  :ensure t)
(global-set-key (kbd "C-c y c") #'aya-create)
(global-set-key (kbd "C-c y e") #'aya-expand)
(global-set-key (kbd "C-o") #'aya-open-line)

(add-hook 'js-mode-hook
          (lambda ()
            ;; Scan the file for nested code blocks
            (imenu-add-menubar-index)
            ;; Activate the folding mode
            (hs-minor-mode t)))

(use-package js2-mode
  :mode "\\.js\\'"
  :commands js2-mode
  :config
  (setq-default
   js2-auto-indent-flag nil
   js2-basic-offset 4
   js2-electric-keys nil
   js2-enter-indents-newline nil
   js2-mirror-mode nil
   js2-mode-show-parse-errors nil
   js2-mode-show-strict-warnings nil
   js2-mode-squeeze-spaces t
   js2-strict-missing-semi-warning nil
   js2-strict-trailing-comma-warning nil
   js2-bounce-indent-p t
   js2-global-externs (list "$" "ko" "_")
   js2-highlight-external-variables t
   js2-mode-show-parse-errors t
   js2-mode-show-strict-warnings t)
  (add-hook 'js2-mode-hook 'flycheck-mode))

(use-package simple-httpd
  :ensure t)

;; (use-package skewer-mode
;;   :ensure t)
;; (add-hook 'js2-mode-hook 'skewer-mode)
;; (add-hook 'css-mode-hook 'skewer-css-mode)
;; (add-hook 'html-mode-hook 'skewer-html-mode)

(use-package impatient-mode
  :ensure t)

(use-package typescript-mode
  :ensure t)

(use-package web-mode
  :ensure t)


(add-to-list 'auto-mode-alist '("/project/dir/.*\\.js\\'" . web-mode))
(setq web-mode-content-types-alist
      '(("jsx"  . "/project/dir/.*\\.js[x]?\\'")))
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
	  (lambda ()
	    (when (string-equal "tsx" (file-name-extension buffer-file-name))
	      (setup-tide-mode))))

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
	      (append flycheck-disabled-checkers
		      '(javascript-jshint)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)
(flycheck-add-mode 'javascript-eslint 'javascript-mode)

(use-package rjsx-mode
  :ensure t)
(add-to-list 'auto-mode-alist '("components\\/.*\\.js\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . rjsx-mode))
(flycheck-add-mode 'javascript-eslint 'rjsx-mode)

(load "nameses")
(require 'desktop)
(require 'nameses)
(global-set-key (kbd "<f9>")     'nameses-load)
(global-set-key (kbd "C-<f9>")   'nameses-prev)
(global-set-key (kbd "C-S-<f9>") 'nameses-save)

(use-package magit
  :ensure t)
(global-set-key (kbd "C-x g") 'magit-status)
(setenv "GIT_SSH" "C:/Program Files/PuTTY/plink.exe")

(use-package undo-tree
     :ensure t
     :init
     (global-undo-tree-mode))

(global-hl-line-mode t)

(use-package beacon
  :ensure t
  :config
  (beacon-mode 1)
  (setq beacon-color "#666600")
  )

(set-face-background 'highlight-indentation-face "gray20")
(set-face-background 'highlight-indentation-current-column-face "dark red")

(use-package browse-url-dwim
  :ensure t)
(require 'browse-url-dwim)

(browse-url-dwim-mode 1)

;; place the cursor on a URL
;; press "C-c b"

;; select some text
;; press "C-c g"

;; to turn off confirmations
(setq browse-url-dwim-always-confirm-extraction nil)

;; set specific browser to open links
(setq browse-url-browser-function 'browse-url-default-windows-browser)

(use-package ac-math
  :ensure t
  )

(use-package dtrt-indent
  :ensure t)

(use-package prettier-js
  :ensure t)
(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook 'prettier-js-mode)
(add-hook 'rjsx-mode-hook 'prettier-js-mode)

(use-package tide
	:ensure t
	:after (typescript-mode company flycheck)
	:hook ((typescript-mode . tide-setup)
				 (typescript-mode . tide-hl-identifier-mode)
				 (before-save . tide-format-before-save)))

(add-hook 'rjsx-mode-hook 'tide-mode)
