;;; my-gtd/org-gtd-constants.el -*- lexical-binding: t; -*-



(defun org-gtd--path (file)
  "Return the full path to FILE.org. This assumes the file is located in `org-gtd-directory'."
  (f-join org-gtd-directory (concat file ".org")))

(defun org-gtd-inbox-path ()
  "Return the full path to the inbox file."
  (org-gtd--path org-gtd-inbox-file-basename))

(defconst org-gtd-actionable-file-basename "actionable"
  "Name of Org file listing all actionable items.")

(defconst org-gtd-inbox-file-basename "inbox"
  "Name of Org file listing all captured items.")

(defconst org-gtd-incubate-file-basename "incubate"
  "Name of Org file listing all someday/maybe items.")


(defconst org-gtd-actions   ".*Actions")
(defconst org-gtd-delegated ".*Delegated")
(defconst org-gtd-incubate  ".*Incubate")
(defconst org-gtd-scheduled ".*Scheduled")
(defconst org-gtd-projects  ".*Projects")
(defconst org-gtd-englishscore  ".*EnglishScore")
(defvar org-stuck-projects)

(defconst org-gtd-complete-projects
  "+LEVEL=2+CATEGORY=\"Projects\""
  "How to identify projects in the GTD system.")

(defconst org-gtd-stuck-projects
  '("+LEVEL=2-DONE+CATEGORY=\"Projects\"" ("TODO" "NEXT" "WAIT") nil "")
  "How to identify stuck projects in the GTD system.
This is a list of four items, the same type as in `org-stuck-projects'.")

(defvar org-gtd-command-map (make-sparse-keymap)
  "Keymap for function `org-gtd-user-input-mode', a minor mode.")


(define-minor-mode org-gtd-user-input-mode
  "Minor mode for org-gtd."
  nil "GTD " org-gtd-command-map
  (setq-local header-line-format
              (substitute-command-keys
               "\\<org-gtd-command-map>Clarify buffer.  Finish \
`\\[org-gtd--clarify-finalize]'.")))


(defun org-gtd--clarify-item ()
  "User interface to reflect on and clarify the current inbox item."
  (org-gtd-user-input-mode 1)
  (recursive-edit))


(defun org-gtd--clarify-finalize ()
  "Finalize the clarify process."
  (interactive)
  (org-gtd-user-input-mode -1)
  (exit-recursive-edit))

(define-key org-gtd-command-map (kbd "C-c C-c") 'org-gtd--clarify-finalize)


