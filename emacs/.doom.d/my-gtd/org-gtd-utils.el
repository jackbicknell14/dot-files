;;; my-gtd/org-gtd-utils.el -*- lexical-binding: t; -*-


;;;; Commands

(defcustom org-gtd-process-item-hooks '(org-set-tags-command)
  "Enhancements to add to each item as they get processed from the inbox."
  :version "1.0.4"
  :type 'hook
  :options '(org-set-tags-command org-set-effort org-priority))


(defun org-gtd-find-or-create-and-save-files ()
  "Call this function to bootstrap the files used by org-gtd."
  (interactive)
  (mapcar
   (lambda (buffer) (with-current-buffer buffer (save-buffer) buffer))
   `(,(org-gtd--actionable-file) ,(org-gtd--incubate-file) ,(org-gtd--inbox-file))))


(defun org-gtd--decorate-item ()
  "Apply hooks to add metadata to a given GTD item."
  (goto-char (point-min))
  (dolist (hook org-gtd-process-item-hooks)
    (funcall hook)))

(defun gtd-inbox-todo-count ()
  (length (org-map-entries t "/+TODO" '("~/.org/gtd/inbox.org")))
  )
