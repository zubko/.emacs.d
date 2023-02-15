;;; Mac related config

;; Set font and font size for Mac

(set-face-attribute 'default nil :family "Fira Code")
(set-face-attribute 'default nil :height 175)

;; Keybinds
(global-set-key [(s a)] 'mark-whole-buffer)
(global-set-key [(s v)] 'yank)
(global-set-key [(s c)] 'kill-ring-save)
(global-set-key [(s s)] 'save-buffer)
(global-set-key [(s l)] 'goto-line)
(global-set-key [(s w)]
                (lambda () (interactive) (delete-window)))
(global-set-key [(s z)] 'undo)

(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'super)

;; Cursor box and color (for Aquamacs)
(setq-default cursor-type 'box)
