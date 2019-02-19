;; Initialize elisp package management
(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

;; BASIC CUSTOMIZATIONS
;; ===
;; This variable allows me to jump by sentence in plaintext
;; files where I only use one space to separate sentences
(setq sentence-end-double-space nil)

;; This variable adds the behavior that C-n at the end
;; of a buffer goes ahead and inserts newlines for you
(setq next-line-add-newlines t)

;; Remove trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

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

;; Here, I am attempting to replicate the functionality I had in Vi
;; via `nnoremap <C-n> O<Esc>`.
(defun push-newline()
 ;; The push-newline function inserts a newline above the line
 ;; where the point is currently located.
 (interactive)
 (beginning-of-line nil)
 (insert-char ?\n)
 (backward-char nil))
;; By default, typing C-j inserts a newline and follows it, but
;; I happen to like having the cursor stay where it is because
;; <RET> is perfectly adequate for doing what C-j does.
(substitute-key-definition
 'electric-newline-and-maybe-indent 'push-newline (current-global-map))
