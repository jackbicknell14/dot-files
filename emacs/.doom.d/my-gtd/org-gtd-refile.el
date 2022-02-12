;;; my-gtd/org-gtd-refile.el -*- lexical-binding: t; -*-
(setq org-refile-allow-creating-parent-nodes 'confirm)

(defun org-gtd--refile-incubate ()
  "Refile an item to the incubate file."
  (setq user-refile-targets org-refile-targets)
  (setq org-refile-targets (org-gtd--refile-incubate-targets))
  (org-refile)
  (setq org-refile-targets user-refile-targets))

(defun org-gtd--refile-project ()
  "Refile an item to the project file."
  (setq user-refile-targets org-refile-targets)
  (setq org-refile-use-outline-path 'full-file-path)
  (setq org-refile-targets (org-gtd--refile-project-targets))
  (org-refile)
  (setq org-refile-targets user-refile-targets))

(defun org-gtd--refile-englishscore ()
  "Refile an item to the project file."
  (setq user-refile-targets org-refile-targets)
  (setq org-refile-use-outline-path 'full-file-path)
  (setq org-refile-targets (org-gtd--refile-englishscore-targets))
  (org-refile nil nil (org-gtd--refile-target org-gtd-englishscore))
  (setq org-refile-targets user-refile-targets))


(defun org-gtd--refile-targets ()
  "Return the refile targets specific to org-gtd."
  (append (org-gtd--refile-incubate-targets) (org-gtd--refile-action-targets)))

(defun org-gtd--refile-englishscore-targets ()
  "Generate refile targets for project items."
  `((,(org-gtd--path org-gtd-actionable-file-basename) :level . 1 )))

(defun org-gtd--refile-project-targets ()
  "Generate refile targets for project items."
  `((,(org-gtd--path org-gtd-actionable-file-basename) :level . 2 )))

(defun org-gtd--refile-incubate-targets ()
  "Generate refile targets for incubation items."
  `((,(org-gtd--path org-gtd-incubate-file-basename) :level . 1)))

(defun org-gtd--refile-action-targets ()
  "Generate refile targets for actionable items."
  `((,(org-gtd--path org-gtd-actionable-file-basename) :maxlevel . 1)))


(defun org-gtd--org-element-pom (element)
  "Return buffer position for start of Org ELEMENT."
  (org-element-property :begin element))

(defun org-gtd--nextify ()
  "Add the NEXT keyword to the first action/task of the project.
Add the TODO keyword to all subsequent actions/tasks."
  (cl-destructuring-bind
      (first-entry . rest-entries)
      (cdr (org-map-entries (lambda () (org-element-at-point)) t 'tree))
    (org-element-map
        (reverse rest-entries)
        'headline
      (lambda (myelt)
        (org-entry-put (org-gtd--org-element-pom myelt) "TODO" "TODO")))
    (org-entry-put (org-gtd--org-element-pom first-entry) "TODO" "NEXT")))

(defun org-gtd--refile-target (heading-regexp)
  "Filters refile targets generated from `org-gtd--refile-targets' using HEADING-REGEXP."
  (let* ((backup org-refile-targets)
         (org-refile-targets (org-gtd--refile-targets))
         (results (cl-find-if
                   (lambda (rfloc)
                     (string-match heading-regexp
                                   (car rfloc)))
                   (org-refile-get-targets)))
         (org-refile-targets backup))
    results))
