;; Emacs config: root file

;; TODO:
;; - add more sophisticated auto-save, it would be nice if it saved with 10 seconds after the edit, and didn't save if file wasn't changed
;; - add spell check for english in text and org mode
;; - add modes for missing programming languages
;; - add dark color scheme
;; - remove the blank top lines in the full screen mode
;; - organise much better
;; - try auto-completion modules


;; Disable cursor blink
(blink-cursor-mode 0)

;; Disable toolbar
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode 0))

;; Disable scrollbar
(if (fboundp 'scroll-bar-mode)
    (scroll-bar-mode 0))

;; For Cocoa
;; In every buffer, the line which contains the cursor 
;; will be fully highlighted
(if (eq window-system 'ns)
    (global-hl-line-mode 1))

;; Prevent cursor jumping when scrolling
(setq scroll-step 1)

;; Don't create backup files
(setq make-backup-files nil) 

;; Show line-number in the mode line
(line-number-mode 1)

;; Show column-number in the mode line
(column-number-mode 1)

;; Identation in org-mode
(setq org-startup-indented t)

;; Word-wrap enabled by default
(global-visual-line-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(visual-line-fringe-indicators (quote (nil right-curly-arrow))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Add 'modules' dir to load path
(defvar config-root-dir (file-name-directory load-file-name)
  "The root dir of this config.")
(defvar config-modules-dir (expand-file-name  "modules" config-root-dir)
  "This directory houses all of the built-in modules.")
(add-to-list 'load-path config-modules-dir)

;; Auto-saving the buffer to the same file
(require 'real-auto-save)
(add-hook 'text-mode-hook 'turn-on-real-auto-save)
(add-hook 'org-mode-hook 'turn-on-real-auto-save)
(setq real-auto-save-interval 10) ;; in seconds
