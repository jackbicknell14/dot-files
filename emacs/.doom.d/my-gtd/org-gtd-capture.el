;;; my-gtd/org-gtd-capture.el -*- lexical-binding: t; -*-

;; Commands - Capture
(defun org-gtd-capture (&optional GOTO KEYS)
  "Capture something into the GTD inbox.
   Wraps the function `org-capture' to ensure the inbox exists.
   For GOTO and KEYS, see `org-capture' documentation for the variables of the same name."
  (interactive)
  (kill-buffer (org-gtd--inbox-file))
  (org-capture GOTO KEYS))
