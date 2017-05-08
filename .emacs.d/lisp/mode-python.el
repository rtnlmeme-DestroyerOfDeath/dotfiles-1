;; Python

(defun python-set-compiler ()
  "Returns the value of the shebang if any, `python-shell-interpreter' otherwise."
  (let* ((firstline
          (save-excursion (beginning-of-buffer) (buffer-substring-no-properties (line-beginning-position) (line-end-position))))
         (interpreter
          (if (not (string-match "^#!" firstline))
              python-shell-interpreter
            (substring firstline 2))))
    (set (make-local-variable 'compile-command)
         (concat interpreter " " (shell-quote-argument buffer-file-name)))))

(add-hook-and-eval
 'python-mode-hook
 (lambda ()
   (set (make-local-variable 'compilation-scroll-output) t)
   (python-set-compiler)))

;; Doc lookup. Requires the python.info file to be installed. See
;; https://bitbucket.org/jonwaltman/pydoc-info/.
;; (add-to-list 'load-path "~/path/to/pydoc-info")
;; (require 'pydoc-info nil t)

(provide 'mode-python)
