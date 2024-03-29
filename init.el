;; Emacs config: root file

;; TODO:
;; - add exit confirmation
;; - save window location locally for GUI mode
;; - add spell check for english in text and org mode
;; - try auto-completion modules
;; - add modes for missing programming languages
;; -- add TypeScript mode
;; - try Copilot package
;; - get zenburn color scheme as git submodule
;; - organise much better

;; =======================================
;; Beginning of config from https://github.com/andschwa/.emacs.d
;; TODO: add other parts that I like

;; Avoiding bugs.
(setq load-prefer-newer t)

;; Improved TLS Security.
(with-eval-after-load 'gnutls
  (custom-set-variables
   '(gnutls-verify-error t)
   '(gnutls-min-prime-bits 3072)))

;; Fix TLS error on emacs 26 and libgnutls (Debian 10 current versions)
;; https://www.reddit.com/r/orgmode/comments/cvmjjr/workaround_for_tlsrelated_bad_request_and_package/
(when (and (>= libgnutls-version 30603)
            (version<= emacs-version "26.2"))
   (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))

;; Package setup.
(eval-when-compile
  (require 'package)
  (add-to-list 'package-archives
               '("melpa" . "https://melpa.org/packages/") t)
  (add-to-list 'package-archives
               '("org" . "https://orgmode.org/elpa/") t)
  (add-to-list 'package-archives
               '("melpa-stable" . "https://stable.melpa.org/packages/") t)
  )


;; Initializes the package infrastructure
(package-initialize)

;; If there are no archived package contents, refresh them
(when (not package-archive-contents)
  (package-refresh-contents))

(eval-when-compile
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))
  (require 'use-package))

(customize-set-variable 'use-package-enable-imenu-support t)
(customize-set-variable 'use-package-always-ensure t)

(defmacro use-feature (name &rest args)
  "Like `use-package' for NAME and ARGS, but with `:ensure' nil."
  (declare (indent defun))
  `(use-package ,name
     :ensure nil
     ,@args))

(use-package quelpa :disabled)
(use-package quelpa-use-package :disabled)

(customize-set-variable 'quelpa-use-package-inhibit-loading-quelpa t)

;; Lisp list, string, and file extensions.
(use-package dash)
(use-package s)
(use-package f)

;; Save data files consistently.
(use-package no-littering)


;; ======================
;; Modules dir

;; Root config dir
(defvar config-root-dir (file-name-directory load-file-name)
  "The root dir of this config.")

;; Add 'modules' dir to load path
(defvar config-modules-dir (expand-file-name "modules" config-root-dir)
  "This directory houses all of the built-in modules.")
(add-to-list 'load-path config-modules-dir)


;; ======================
;; Better defaults from https://git.sr.ht/~technomancy/better-defaults
(use-package better-defaults)


;; ======================
;; My settings

;; Disable welcome message
(setq inhibit-startup-screen t)

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
;; TODO: check if `better-defaults` handles backups well
;; (setq make-backup-files nil)

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

;; Reload the file if it was changed in another editor
(global-auto-revert-mode t)

;; iterm2 mouse support
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (defun track-mouse (e))
  (setq mouse-sel-mode t))

;; Better undo
(use-package undo-tree)
(global-undo-tree-mode)

;; Move text
(use-package move-text)
(move-text-default-bindings) ;; M-up, M-down
(global-set-key [C-s-down] 'move-text-down) ;; VS Code
(global-set-key [C-s-up] 'move-text-up) ;; VS Code

;; auto-indent after moving
(defun indent-region-advice (&rest ignored)
  (let ((deactivate deactivate-mark))
    (if (region-active-p)
        (indent-region (region-beginning) (region-end))
      (indent-region (line-beginning-position) (line-end-position)))
    (setq deactivate-mark deactivate)))
(advice-add 'move-text-up :after 'indent-region-advice)
(advice-add 'move-text-down :after 'indent-region-advice)

;; scroll half of the screen
(use-package golden-ratio-scroll-screen)
(global-set-key [remap scroll-down-command] 'golden-ratio-scroll-screen-down)
(global-set-key [remap scroll-up-command] 'golden-ratio-scroll-screen-up)
(setq golden-ratio-scroll-highlight-flag nil)
(setq golden-ratio-scroll-screen-ratio 2.0)

;; ===========================================
;; Themes

;; local themes
(defvar config-themes-dir (expand-file-name "themes" config-root-dir)
  "The directory for custom color themes")
(add-to-list 'custom-theme-load-path config-themes-dir)

;; from package
(use-package material-theme)
(load-theme 'material t)

;; ===========================================
;; Dev

(use-package magit
  :pin melpa-stable
  :bind (("C-x g" . magit)))

;; jump to function definition (at least in emacs-lisp)
(global-set-key (kbd "C-h C-f") 'find-function)

;; ===========================================
;; Import from other files

;; Local settings
(load "~/.emacs.d/local.el")

;; Platform settings
(when (eq system-type 'darwin)
  (load "~/.emacs.d/init-mac.el"))

;; FS utils
(load "~/.emacs.d/init-fs.el")
