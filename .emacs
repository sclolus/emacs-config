
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq-default c-default-style `((java-mode . "linux") (other . "linux"))
 c-basic-offset 4
 jave-basic-offset 4
 tab-width 4
 indent-tabs-mode t
 column-number-mode t)
(add-to-list 'load-path "~/.emacs.d/rust")
(add-to-list 'load-path "~/.emacs.d/json")
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
(add-to-list 'auto-mode-alist '("\\.cl\\'". c-mode))
(add-to-list 'auto-mode-alist '("\\.s\\'" . nasm-mode))

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(unless (package-installed-p 'use-package)
 (package-refresh-contents)
 (package-install 'use-package))
(use-package undo-tree
 :ensure t
 :diminish
 :config
 (global-undo-tree-mode)
 (setq undo-tree-visualizer-timestamps t)
 (setq undo-tree-visualizer-diff t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(gud-gdb-command-name "gdb --annotate=1")
 '(large-file-warning-threshold nil)
 '(package-selected-packages (quote (caml slime trr nasm-mode helm)))
 '(send-mail-function (quote mailclient-send-it))
 '(tab-stop-list
   (quote
	(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 86 90 94 0))))
(add-hook 'c-mode-hook
		  (lambda () (add-to-list 'write-file-functions 'delete-trailing-whitespace)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(setq mac-option-modifier 'super)
(global-set-key (kbd "M-<left>") 'windmove-left)
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<up>") 'windmove-up)
(global-set-key (kbd "M-<down>") 'windmove-down)

(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "/usr/share/emacs/site-lisp")
(require 'column-marker)
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

;; (load "/Users/sclolus/.opam/default/share/emacs/site-lisp/tuareg-site-file")
(load "/Users/sclolus/.opam/ocaml-base-compiler.4.07.0/share/emacs/site-lisp/tuareg-site-file")
(let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var" "share")))))
  (when (and opam-share (file-directory-p opam-share))
	;; Register Merlin
	(add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
	(autoload 'merlin-mode "merlin" nil t nil)
	;; Automatically start it in OCaml buffers
	(add-hook 'tuareg-mode-hook 'merlin-mode t)
	(add-hook 'caml-mode-hook 'merlin-mode t)
	;; Use opam switch to lookup ocamlmerlin binary
	(setq merlin-command 'opam)))
(require 'undo-tree)
(column-marker-3 80)

;*******************************************************************************;
;                                                                               ;
;                   42_header.el for 42 Emacs header                            ;
;                   Created on : Tue Jun 18 10:46:22 2013                       ;
;                   Made by : David "Thor" GIRON <thor@42.fr>                   ;
;                                                                               ;
;*******************************************************************************;



(require 'string)
(require 'list)
(require 'comments)



;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    filename_____________________________.ext          :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: login____ <mail_______@student.42.fr>      +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: yyyy/mm/dd 15:27:11 by login____         #+#    #+#              ;
;    Updated: 2018/10/01 07:13:11 by sclolus          ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;



(global-set-key (kbd "C-c C-h") 'header-insert)
(setq write-file-hooks (cons 'header-update write-file-hooks))


(set 'user-login (let ((login (getenv "USER")))
				   (if (string= login nil)
					   "marvin"
					 login)
				   )
	 )


(set 'user-mail (let ((mail (getenv "MAIL")))
				   (if (string= mail nil)
					   "marvin@42.fr"
					 mail)
				   )
	 )


(set 'left-std-margin 5)
(set 'right-std-margin 5)
(set 'info-std-width 41)


(set 'ft-1 "        :::      ::::::::")
(set 'ft-2 "      :+:      :+:    :+:")
(set 'ft-3 "    +:+ +:+         +:+  ")
(set 'ft-4 "  +#+  +:+       +#+     ")
(set 'ft-5 "+#+#+#+#+#+   +#+        ")
(set 'ft-6 "     #+#    #+#          ")
(set 'ft-7 "    ###   ########.fr    ")
(set 'ft-std-width 25)



;*******************************************************************************;


(defun header-chop-str (str n)
  (if (> (length str) n)
	  (let* ((max (- n 3))
	  		(new (substring str 0 max)))
	  	(concat new "..."))
	str)
  )

(defun header-make-left-margin ()
  "Creates the header comments start token and left margin"
  (let ((fill (string-fill (- left-std-margin (comments-start-token-length)))))
	(concat (comments-start-token) fill))
  )

(defun header-make-right-margin ()
  "Creates the header right margin and comments end token"
  (let ((fill (string-fill (- right-std-margin (comments-end-token-length)))))
	(concat fill (comments-end-token)))
  )

(defun header-make-central-gap (left-chunk right-chunk)
  "Creates the gap between the left infos block and the right logo"
  (string-fill (- line-std-width
				  (string-length left-chunk)
				  (string-length right-chunk)))
  )

(defun header-make-file-name ()
  "Creates the 'file.ext' entry of the header."
  (let* ((filename (header-chop-str (file-name-nondirectory (buffer-file-name))
									info-std-width))
		 (fill (string-fill (- info-std-width (string-length filename)))))
	(concat filename fill))
  )

(defun header-make-by ()
  "Creates the 'By: login <mail>' entry of the header."
  (let* ((mail-span (- info-std-width (+ (length user-login) 7)))
		 (by (concat "By: " user-login " <" (header-chop-str user-mail mail-span) ">"))
		 (fill (string-fill (- info-std-width (string-length by)))))
	(concat by fill))
  )

(defun header-make-creation-date ()
  "Creates the 'Created: yyyy/mm/dd hh:mm:ss' entry of the header.'"
  (concat "Created: " (format-time-string "%Y/%m/%d %T") " by " user-login)
  )

(defun header-make-update-date ()
  "Creates the 'Updated: yyyy/mm/dd hh:mm:ss' entry of the header.'"
  (concat "Updated: " (format-time-string "%Y/%m/%d %T") " by " user-login)
  )


;*******************************************************************************;



(defun header-insert-line-01 ()
  "Line 1 of the header"
  (comments-insert-bar)
  )

(defun header-insert-line-02 ()
  "Line 2 of the header"
  (comments-insert-empty-line)
  )

(defun header-insert-line-03 ()
  "Line 3 of the header"
  (let* ((left-margin (header-make-left-margin))
		 (right-margin (header-make-right-margin))
		 (central-gap (header-make-central-gap
					   left-margin
					   (concat ft-1 right-margin))))
	(insert (concat left-margin central-gap ft-1 right-margin))
	)
  )

(defun header-insert-line-04 ()
  "Line 4 of the header"
  (let* ((left-margin (header-make-left-margin))
		 (right-margin (header-make-right-margin))
		 (filename (header-make-file-name))
		 (central-gap (header-make-central-gap (concat left-margin filename)
											   (concat ft-2 right-margin))))
	(insert (concat left-margin filename central-gap ft-2 right-margin))
	)
  )

(defun header-insert-line-05 ()
  "Line 5 of the header"
  (let* ((left-margin (header-make-left-margin))
		 (right-margin (header-make-right-margin))
		 (central-gap (header-make-central-gap left-margin
											   (concat ft-3 right-margin))))
	(insert (concat left-margin central-gap ft-3 right-margin))
	)
  )

(defun header-insert-line-06 ()
  "Line 6 of the header"
  (let* ((left-margin (header-make-left-margin))
		 (right-margin (header-make-right-margin))
		 (by (header-make-by))
		 (central-gap (header-make-central-gap (concat left-margin by)
											   (concat ft-4 right-margin))))
	(insert (concat left-margin by central-gap ft-4 right-margin))
	)
  )

(defun header-insert-line-07 ()
  "Line 7 of the header"
  (let* ((left-margin (header-make-left-margin))
		 (right-margin (header-make-right-margin))
		 (central-gap (header-make-central-gap left-margin
											   (concat ft-5 right-margin))))
	(insert (concat left-margin central-gap ft-5 right-margin))
	)
  )

(defun header-insert-line-08 ()
  "Line 8 of the header"
  (let* ((left-margin (header-make-left-margin))
		 (right-margin (header-make-right-margin))
		 (created (header-make-creation-date))
		 (central-gap (header-make-central-gap (concat left-margin created)
											   (concat ft-6 right-margin))))
	(insert (concat left-margin created central-gap ft-6 right-margin))
	)
  )

(defun header-insert-line-09 ()
  "Line 9 of the header"
  (let* ((left-margin (header-make-left-margin))
		 (right-margin (header-make-right-margin))
		 (updated (header-make-update-date))
		 (central-gap (header-make-central-gap (concat left-margin updated)
											   (concat ft-7 right-margin))))
	(insert (concat left-margin updated central-gap ft-7 right-margin))
	)
  )

(defun header-insert-line-10 ()
  "Line 10 of the header"
  (comments-insert-empty-line)
  )

(defun header-insert-line-11 ()
  "Line 11 of the header"
  (comments-insert-bar)
  )



;*******************************************************************************;



(defun header-insert ()
  "Creates a header for the current source file."
  (interactive)
  (save-excursion
	(goto-char (point-min))
	(header-insert-line-01)
	(header-insert-line-02)
	(header-insert-line-03) (newline)
	(header-insert-line-04) (newline)
	(header-insert-line-05) (newline)
	(header-insert-line-06) (newline)
	(header-insert-line-07) (newline)
	(header-insert-line-08) (newline)
	(header-insert-line-09) (newline)
	(header-insert-line-10)
	(header-insert-line-11)
	)
  )


(defun header-update ()
  "Updates the header for the current source file."
  (interactive)
  (save-excursion
    (if (buffer-modified-p)
        (progn
          (goto-char (point-min))
          (if (search-forward "Updated" nil t)
              (progn
                (delete-region
                 (progn (beginning-of-line) (point))
                 (progn (end-of-line) (point)))
				(header-insert-line-09)
                (message "Header up to date."))))))
  nil)



;******************************************************************************;
(provide 'header)
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
(define-key merlin-mode-map (kbd "C-c C-h") 'header-insert)
