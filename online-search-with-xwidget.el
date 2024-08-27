;;; online-search-with-xwidget.el --- Online search tools using xwidget-webkit -*- lexical-binding: t -*-

;; Author: Pablo Cobelli
;; Version: 0.1
;; Package-Requires: ((emacs "25.1"))
;; Keywords: tools, web, search
;; URL: https://github.com/pablocobelli/online-search-with-xwidget

;;; Commentary:

;; This package provides tools to search for information online using xwidget-webkit.
;; It includes functions to open URLs in an xwidget-webkit window, run a Python script
;; with user input, and search the web for documentation.

;;; Code:

(defun oswx-get-user-input-from-prompt (prompt)
  "Prompt the user with PROMPT and return the input."
  (read-string prompt))

(defun oswx-open-url-in-webkit (url-address)
  "Open the given URL address in an existing xwidget-webkit window, or create a new one if none exists."
  (let ((found-window nil))
    ;; Iterate through all windows to check if one is displaying xwidget-webkit
    (dolist (win (window-list))
      (with-selected-window win
        (when (derived-mode-p 'xwidget-webkit-mode)
          (setq found-window win)
          (setq url-found (string= (xwidget-webkit-current-url) url-address)))))

    ;; If no window was found, create a new one
    (unless found-window
      (split-window-right)
      (other-window 1)
      (setq found-window (selected-window)))

    ;; Switch to the found or newly created window
    (select-window found-window)
    (xwidget-webkit-browse-url url-address)
    (xwidget-webkit-fit-width)
    (other-window -1)))

(defun oswx-run-python-script-with-arg (user-input)
  "Run a Python script with USER-INPUT as an argument and display the output."
  (let* ((script-path (expand-file-name "search_with_duckduckgo.py" (file-name-directory load-file-name)))
         (command (format "python3 %s \"%s\"" script-path user-input))
         (output (shell-command-to-string command)))
    (message "%s" (string-trim output))))

(defun oswx-search-online-for-python-docs ()
  "Prompt for input, then search online for Python docs."
  (interactive)
  (let ((user-input (oswx-get-user-input-from-prompt "Search online Python docs for: ")))
    (oswx-open-url-in-webkit (oswx-run-python-script-with-arg user-input))))

(defun oswx-show-word-under-cursor ()
  "Display the word under the cursor in a message."
  (interactive)
  (let ((word (thing-at-point 'word t)))
    (if word
        word
      nil)))

(defun oswx-search-online-for-python-docs-for-word-under-cursor ()
  "Search online for Python docs for the word under the cursor."
  (interactive)
  (let ((user-input (oswx-show-word-under-cursor)))
    (oswx-open-url-in-webkit (oswx-run-python-script-with-arg user-input))))

(defun oswx-search-online ()
  "Prompt for input, then search online for specified terms."
  (interactive)
  (let ((user-input (oswx-get-user-input-from-prompt "Web search terms: ")))
    (oswx-open-url-in-webkit (concat "https://www.google.com/search?q=" user-input))))

(provide 'online-search-with-xwidget)
;;; online-search-with-xwidget.el ends here
