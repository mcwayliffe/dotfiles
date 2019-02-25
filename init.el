;; Initialize elisp package management
(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

;; BASIC CUSTOMIZATIONS
;; ===
(setq
 ;; Allow jumping by sentence in plaintext files where only one space separates
 ;; sentences
 sentence-end-double-space nil
 ;; C-n at the end of a buffer inserts newlines
 next-line-add-newlines t)

;; Remove trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Wrap lines in text files
(add-hook 'text-mode-hook 'auto-fill-mode)
(setq-default fill-column 80)

;; END BASIC CUSTOMIZATIONS

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes (quote (deeper-blue)))
 '(package-selected-packages (quote (go-mode markdown-mode))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; This size font is much more legible on a modern display
(set-face-attribute 'default nil :height 180)

;; Ports of useful text manipulation commands from Vi

;; <n> O
(defun push-newline()
 (interactive)
 (beginning-of-line nil)
 (open-line 1))

;; Without: C-a C-o
(global-set-key (kbd "C-j") 'push-newline)

;; <n> o -- by default, you have to C-e <RET>
(defun open-newline()
  (interactive)
  (end-of-line nil)
  (electric-newline-and-maybe-indent))

;;Without: C-e C-j
(global-set-key (kbd "C-o") 'open-newline)

;; <n> dd
(defun kill-whole-line()
  (interactive)
  (beginning-of-line nil)
  (kill-line 1))

;; Without: C-a C-k C-k
(global-set-key (kbd "s-k") 'kill-whole-line)

;; <n> J
(defun join-next-line()
  (interactive)
  (save-excursion
    (end-of-line nil)
    (forward-char 1)
    (join-line nil)))

;; Without: C-n M-^
(global-set-key (kbd "C-S-j") 'join-next-line)


;; By default, typing C-j inserts a newline and follows it, but
;; I happen to like having the cursor stay where it is because
;; <RET> is perfectly adequate for doing what C-j does.

(add-hook 'after-init-hook #'server-start)
