(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ignored-local-variable-values '((eval prettier-mode t)))
 '(org-agenda-files '("~/org/current.org" "~/org/ideas.org" "~/org/_.org"))
 '(org-agenda-start-on-weekday nil)
 '(org-agenda-todo-ignore-scheduled 'all)
 '(org-agenda-todo-list-sublevels nil)
 '(package-selected-packages
   '(jtsx prettier company tree-sitter-langs tree-sitter helm-core prisma-ts-mode lsp-mode typescript-mode yaml-mode elmacro xclip add-node-modules-path prettier-js flycheck web-mode rjsx-mode wc-mode markdown-mode idris-mode rust-mode helm undo-tree exotica-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;;;; C config ;;;;;
(setq-default c-default-style `((java-mode . "linux") (other . "linux"))
 c-basic-offset 4
 jave-basic-offset 4
 tab-width 4
 indent-tabs-mode t
 column-number-mode t)


(unless (package-installed-p 'use-package)
 (package-refresh-contents)
 (package-install 'use-package))

;;;;; Undo Tree

(use-package undo-tree
 :ensure t
 :diminish
 :config
 (global-undo-tree-mode)
 (setq undo-tree-visualizer-timestamps t)
 (setq undo-tree-visualizer-diff t))


(load-theme 'wheatgrass t) ;; Selected Theme

(menu-bar-mode -1) ;; Disable annoying and useless menu bar
(tool-bar-mode -1) ;; Disable annoying and useless tool bar in gui mode
(scroll-bar-mode -1) ;; Fuck the scroll bar

;; Helm configuration
(require 'helm)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-M-M") 'helm-man-woman)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-h f") 'helm-apropos)
(global-set-key (kbd "C-h r") 'helm-info-emacs)
(global-set-key (kbd "C-h C-l") 'helm-locate-library)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z")  'helm-select-action)
(global-set-key (kbd "C-h a")  'helm-apropos)


;;;;;;;;;;;;;;;;;;;;;
(require 'org)

(defun yashi/org-timestamp-cycle-up (arg)
  (interactive "p")
  (yashi/org-timestamp-cycle (prefix-numeric-value arg)))

(defun yashi/org-timestamp-cycle-down (arg)
  (interactive "p")
  (yashi/org-timestamp-cycle (- (prefix-numeric-value arg))))

(defun yashi/org-timestamp-cycle (cycle)
  (interactive "p")
  (let ((repeat (org-get-repeat)))
    (string-match "\\([.+]\\)?\\(\\+[0-9]+\\)\\([dwmy]\\)" repeat)
    (let ((n (string-to-number (match-string 2 repeat)))
          (what (match-string 3 repeat))
          (whata '(("d" . day) ("m" . month) ("y" . year))))
      (when (string= what "w")
        (setq what "d" n (* n 7)))
      (org-timestamp-change (* cycle n) (cdr (assoc what whata))))))

;; (bind-keys :map org-mode-map
;;            ("M-<right>" . yashi/org-timestamp-cycle-up)
;;            ("M-<left>" . yashi/org-timestamp-cycle-down))

(setq
    org-todo-keywords
     '((sequence "TODO(t)" "|" "DONE(d!)" "SKIP(k!)" "CNCL(c@)")))

;; (define-key org-agenda-mode-map "K"
;;     (lambda () (interactive) (org-agenda-todo '"SKIP")))


(add-hook 'org-agenda-mode-hook
          (lambda ()
                  (local-set-key (kbd "K") (lambda () (interactive) (org-agenda-todo '"SKIP")))))

(require 'flycheck)
(setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jshint json-jsonlist)))


;; Enable eslint checker for web-mode
(flycheck-add-mode 'javascript-eslint 'web-mode)
;; Enable flycheck globally
(add-hook 'after-init-hook #'global-flycheck-mode)

(defun web-mode-init-prettier-hook ()
  (add-node-modules-path)
  (prettier-js-mode))

(add-hook 'web-mode-hook  'web-mode-init-prettier-hook)


;; (global-set-key (kbd "C-M-w") 'clipboard-kill-ring-save)
;; (global-set-key (kbd "C-M-y") 'clipboard-yank)
;; (deprecated)



(setq x-select-enable-clipboard t)
(setq select-enable-clipboard t)

(xclip-mode)
;; (defun copy-from-agenda ()
;;   (interactive)
;;   (move-beginning-of-line 1)
;;   (set-mark-command nil)
;;   (move-end-of-line 1)
;;   (kill-ring-save 3180 3321 1)
;;   (move-beginning-of-line 1)
;;   (next-line 1 1)
;;   (org-agenda-next-line)
;;   (setq last-command-event 111)
;;   (other-window 1)
;;   (setq last-command-event 42)
;;   (org-self-insert-command 1)
;;   (setq last-command-event 42)
;;   (org-self-insert-command 1)
;;   (setq last-command-event 32)
;;   (org-self-insert-command 1)
;;   (setq last-command-event 84)
;;   (org-self-insert-command 1)
;;   (setq last-command-event 79)
;;   (org-self-insert-command 1)
;;   (setq last-command-event 68)
;;   (org-self-insert-command 1)
;;   (setq last-command-event 79)
;;   (org-self-insert-command 1)
;;   (setq last-command-event 32)
;;   (org-self-insert-command 1)
;;   (setq last-command-event 25)
;;   (yank nil)
;;   (setq last-command-event 25)
;;   (org-yank nil)
;;   (setq last-command-event 13)
;;   (org-return)
;;   (other-window 1))


;; (global-set-key (kbd "") 'copy-from-agenda-to-plan)


(use-package company)

  (use-package tree-sitter
  :ensure t
  :config
  ;; activate tree-sitter on any buffer containing code for which it has a parser available
  (global-tree-sitter-mode)
  ;; you can easily see the difference tree-sitter-hl-mode makes for python, ts or tsx
  ;; by switching on and off
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs
  :ensure t
  :after tree-sitter)
(use-package eglot
  :ensure t)

;; Ensure Eglot is launched on Typescript buffers
(add-hook 'typescript-mode-hook 'eglot-ensure)
(add-hook 'jtsx-tsx-mode-hook 'eglot-ensure)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . jtsx-tsx-mode))


;; Ensure Company is maunched in all buffers (not Typescript only)
;; Please tell me a way to make it selective
(add-hook 'after-init-hook 'global-company-mode)

(setq treesit-language-source-alist
   '((bash "https://github.com/tree-sitter/tree-sitter-bash")
     (cmake "https://github.com/uyha/tree-sitter-cmake")
     (css "https://github.com/tree-sitter/tree-sitter-css")
     (elisp "https://github.com/Wilfred/tree-sitter-elisp")
     (go "https://github.com/tree-sitter/tree-sitter-go")
     (html "https://github.com/tree-sitter/tree-sitter-html")
     (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
     (json "https://github.com/tree-sitter/tree-sitter-json")
     (make "https://github.com/alemuller/tree-sitter-make")
     (markdown "https://github.com/ikatyang/tree-sitter-markdown")
     (python "https://github.com/tree-sitter/tree-sitter-python")
     (toml "https://github.com/tree-sitter/tree-sitter-toml")
     (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
     (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
     (yaml "https://github.com/ikatyang/tree-sitter-yaml")
	 (prisma "https://github.com/victorhqc/tree-sitter-prisma")
   ))
(add-to-list 'auto-mode-alist '("\\.prisma\\'" . prisma-ts-mode))


;; Prettier.el configuration
(require 'prettier)
(add-hook 'jtsx-tsx-mode-hook 'prettier-js-mode)


(add-hook 'after-init-hook #'global-prettier-mode)
;; This doesn't work for some reason
(dir-locals-set-class-variables 'prettier-js
                                '((js-mode . ((eval . (prettier-mode t))))))
(dir-locals-set-class-variables 'prettier-js
                                '((typescript-mode . ((eval . (prettier-mode t))))))
;; (dir-locals-set-class-variables 'prettier-js
;;                                 '((tsx-ts-mode . ((eval . (prettier-mode t))))))


(dir-locals-set-directory-class "/home/sclolus/projects/serverless-api" 'prettier-js)
(dir-locals-set-directory-class "/home/sclolus/projects/moonz-backoffice" 'prettier-js)

(provide 'init)
;;; init.el ends here


;; (add-hook 'org-mode
;; 		  (lambda ()
;; 			(local-set-key (kbd "C-c h") '

(windmove-default-keybindings)

(global-set-key (kbd "C-x C-b") 'switch-to-buffer)
(global-set-key (kbd "C-x b") 'helm-mini)
