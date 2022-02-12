;; my-gtd/org-gtd-inbox.el -*- lexical-binding: t; -*-

;; Commands - Process [Edit, Tag, Prioritise, Estimate, Refile]
(defun org-gtd--process-inbox-inner ()
  (mapc (lambda(entry)
        (goto-char entry)
        (org-narrow-to-element)
        (org-show-subtree)
        (org-gtd--process-inbox-element)
        )
        (org-map-entries (lambda () (point)) "TODO=\"TODO\"" 'file)
        ))

(defun org-gtd-process-inbox ()
  "Process the GTD inbox. Use this once a day and/or weekly as part of the weekly review."
  (interactive)
  (org-gtd-find-or-create-and-save-files)
  (org-gtd-agenda)
  (delete-other-windows)
  (split-window-right -150)
  (select-window (next-window))
  (set-buffer (org-gtd--inbox-file))
  (display-buffer-same-window (org-gtd--inbox-file) '())
  (goto-char (point-min))
  (catch 'stop-inbox (org-gtd--process-inbox-inner))
  (widen)
  (beginning-of-buffer)
  (save-buffer (org-gtd--inbox-file))
  (select-window (next-window))
  (delete-other-windows)
  (org-agenda-redo)
)


(defun org-gtd--process-inbox-element ()
  "With point on an item, choose which GTD action to take."
  (let ((action
         (read-multiple-choice
          "What to do with this item?"
          '((?q "quick" "quick item: < 2 minutes, done!")
            (?t "thrash" "this has no value to me")
            (?e "englishscore" "add to my englishscore list")
            (?n "next" "do this when possible")
            (?i "incubate" "I'll come back to this later")
            (?d "delegate" "give it to someone")
            (?c "calendar" "do this at a certain time")
            (?a "archive" "Store this where you store knowledge")
            (?p "(add)project" "add an action to a project")
            (?P "(new)project" "multiple steps required to completion")
            (?x "exit" "Quit")
            ))))
    (cl-case (car action)
      (?q (org-gtd--quick-action))
      (?t (org-gtd--trash))
      (?n (org-gtd--single-action))
      (?e (org-gtd--englishscore))
      (?i (org-gtd--incubate))
      (?d (org-gtd--delegate))
      (?c (org-gtd--calendar))
      (?a (org-gtd--archive))
      (?p (org-gtd--project-add))
      (?P (org-gtd--project-new))
      (?x (org-gtd--stop-processing)))))



;; GTD commands
(defun org-gtd--stop-processing ()
  (throw 'stop-inbox '())
  )


(defun org-gtd--quick-action ()
  "Process GTD inbox item by doing it now. Mark it as done and archive."
  (org-todo "DONE")
  (org-archive-subtree))


(defun org-gtd--trash ()
  "Mark GTD inbox item as cancelled and archive it."
  (org-todo "CANCELED")
  (org-archive-subtree))


(defun org-gtd--single-action ()
  "Process GTD inbox item as a single action.
Allow the user apply user-defined tags from
`org-tag-persistent-alist', `org-tag-alist' or file-local tags in
the inbox.  Set as a NEXT action and refile to
`org-gtd-actionable-file-basename'."
  (org-gtd--clarify-item)
  (org-gtd--decorate-item)
  (org-todo "NEXT")
  (org-refile nil nil (org-gtd--refile-target org-gtd-actions)))


(defun org-gtd--englishscore ()
  "Process GTD inbox item by incubating it.
Allow the user apply user-defined tags from
`org-tag-persistent-alist', `org-tag-alist' or file-local tags in
the inbox.  Refile to `org-gtd-incubate-file-basename'."
;; (org-gtd--decorate-item)
;; (org-schedule 0)
  (org-gtd--clarify-item)
  (org-gtd--refile-englishscore))


(defun org-gtd--incubate ()
  "Process GTD inbox item by incubating it.
Allow the user apply user-defined tags from
`org-tag-persistent-alist', `org-tag-alist' or file-local tags in
the inbox.  Refile to `org-gtd-incubate-file-basename'."
;; (org-gtd--decorate-item)
;; (org-schedule 0)
  (org-gtd--clarify-item)
  (org-gtd--refile-incubate))


(defun org-gtd--delegate ()
  "Process GTD inbox item by delegating it.
Allow the user apply user-defined tags from
`org-tag-persistent-alist', `org-tag-alist' or file-local tags in
the inbox.  Set it as a waiting action and refile to
`org-gtd-actionable-file-basename'."
  (org-gtd--clarify-item)
  (org-gtd--decorate-item)
  (org-todo "WAIT")
  (org-set-property "DELEGATED_TO" (read-string "Who will do this? "))
  (org-schedule 0)
  (org-refile nil nil (org-gtd--refile-target org-gtd-delegated)))


(defun org-gtd--calendar ()
  "Process GTD inbox item by scheduling it.
Allow the user apply user-defined tags from
`org-tag-persistent-alist', `org-tag-alist' or file-local tags in
the inbox.  Refile to `org-gtd-actionable-file-basename'."
  (org-gtd--clarify-item)
  (org-gtd--decorate-item)
  (org-schedule 0)
  (org-refile nil nil (org-gtd--refile-target org-gtd-scheduled)))


(defun org-gtd--archive ()
  "Process GTD inbox item as a reference item."
  (org-todo "DONE")
  (org-archive-subtree))


(defun org-gtd--project-new ()
  "Process GTD inbox item by transforming it into a project.
Allow the user apply user-defined tags from
`org-tag-persistent-alist', `org-tag-alist' or file-local tags in
the inbox.  Refile to `org-gtd-actionable-file-basename'."
  (org-gtd--clarify-item)
  (org-gtd--decorate-item)
  (org-gtd--nextify)
  (org-gtd--refile-project)
  (with-current-buffer (org-gtd--actionable-file)
    (org-update-statistics-cookies t)))

(defun org-gtd--project-add ()
  "Process GTD inbox item by transforming it into a project.
Allow the user apply user-defined tags from
`org-tag-persistent-alist', `org-tag-alist' or file-local tags in
the inbox.  Refile to `org-gtd-actionable-file-basename'."
  (org-gtd--clarify-item)
  (org-gtd--decorate-item)
  (org-gtd--refile-project)
  (with-current-buffer (org-gtd--actionable-file)
    (org-update-statistics-cookies t)))
