;;; File related utils

;; use-case: change notes without reordering them when they are sorted by date
(defun save-buffer-preserving-modtime ()
  "Call `save-buffer', but keep the visited file's modtime the same."
  (interactive)
  (let ((original-time (visited-file-modtime)))
    (save-buffer)
    (set-file-times buffer-file-name original-time)
    (set-visited-file-modtime original-time)))

; Enable the shortcut to edit the file easier
; (global-set-key (kbd "C-x C-s") 'save-buffer-preserving-modtime)
