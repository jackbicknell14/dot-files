;;; my-gtd/org-gtd-archive.el -*- lexical-binding: t; -*-

(defun org-gtd-archive-done-englishscore ()
  (interactive)
  (org-map-entries (lambda ()
                     (setq org-map-continue-from (org-element-property
                                                  :begin
                                                  (org-element-at-point)))
                     (org-archive-subtree-default))
                   "+TODO=\"DONE\"+CATEGORY=\"EnglishScore\"" 'file))
(defun org-gtd-archive-done-actions ()
  (interactive)
  (org-map-entries (lambda ()
                     (setq org-map-continue-from (org-element-property
                                                  :begin
                                                  (org-element-at-point)))
                     (org-archive-subtree-default))
                   "+TODO=\"DONE\"+CATEGORY=\"Actions\"" 'file))

(defun org-gtd--current-project-states ()
  "Return a list of the task states for the current project."
  (cdr (org-map-entries
        (lambda ()
          (org-entry-get
           (org-gtd--org-element-pom (org-element-at-point))
           "TODO"))
        t
        'tree)))


(defun org-gtd--project-complete-p (task-states)
  "Return t if project complete, nil otherwise.
A project is considered complete when all TASK-STATES are
marked with a done `org-todo-keyword'."
  (seq-every-p (lambda (x) (string-equal x "DONE")) task-states))


(defun org-gtd--project-canceled-p (task-states)
  "Return t if project canceled, nil otherwise.
A project is considered canceled when the last of the TASK-STATES is
marked with a canceled `org-todo-keyword'."
  (string-equal "CANCELED" (car (last task-states))))


(defun org-gtd-archive-complete-projects ()
  "Archive all projects for which all actions/tasks are marked as done.
Done here is any done `org-todo-keyword'."
  (interactive)
  (let ((backup org-use-property-inheritance)
        (org-use-property-inheritance "CATEGORY"))
    (with-current-buffer (org-gtd--actionable-file)
      (org-map-entries
       (lambda ()
         (let ((task-states (org-gtd--current-project-states)))
           (when (or (org-gtd--project-complete-p task-states)
                     (org-gtd--project-canceled-p task-states))
             (setq org-map-continue-from (org-element-property
                                          :begin
                                          (org-element-at-point)))
             (org-archive-subtree-default))))

       org-gtd-complete-projects))
    (setq org-use-property-inheritance backup)))
