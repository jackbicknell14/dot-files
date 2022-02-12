;;; my-gtd/org-gtd-buffer.el -*- lexical-binding: t; -*-


(defun org-gtd--inbox-file ()
  "Create or return the buffer to the GTD inbox file."
  (org-gtd--gtd-file-buffer org-gtd-inbox-file-basename))

(defun org-gtd--actionable-file ()
  "Create or return the buffer to the GTD actionable file."
  (org-gtd--gtd-file-buffer org-gtd-actionable-file-basename))

(defun org-gtd--incubate-file ()
  "Create or return the buffer to the GTD incubate file."
  (org-gtd--gtd-file-buffer org-gtd-incubate-file-basename))

(defun org-gtd--actionable-archive ()
  "Create or return the buffer to the archive file for the actionable items."
  (let* ((filename (string-join `(,(buffer-file-name (org-gtd--actionable-file)) "archive") "_"))
        (archive-file (f-join org-gtd-directory filename)))
    (find-file archive-file)))


(defun org-gtd--gtd-file-buffer (gtd-type)
  "Return a buffer to GTD-TYPE.org.
Create the file and template first if it doesn't already exist."
  (let* ((file-path (org-gtd--path gtd-type))
         (file-buffer (find-file-noselect file-path)))
    (or (f-file-p file-path)
        (with-current-buffer file-buffer
          (org-mode)
          (insert (symbol-value
                   (intern
                    (string-join
                     `("org-gtd-" ,gtd-type "-template")))))
          (org-mode-restart)
          (save-buffer)))
    file-buffer))
