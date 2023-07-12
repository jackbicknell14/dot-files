;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq doom-theme 'doom-palenight
      doom-font (font-spec :family "Roboto Mono" :size 14)
      doom-variable-pitch-font (font-spec :family "Arial" :style "Arial" :height 1.3)
      display-line-numbers-type 'relative
      user-full-name "Jack Bicknell"
      user-mail-address "jackbicknell@gmail.com"
      undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      truncate-string-ellipsis "…"                ; Unicode ellispis are nicer than "...", and also save /precious/ space
      scroll-margin 2                             ; It's nice to maintain a little margin
      display-time-mode 1                         ; Enable time in the mode-line
      global-subword-mode 1                       ; Iterate through CamelCase words
      scroll-margin 30
      )
(remove-hook 'doom-first-buffer-hook #'global-hl-line-mode)

(unless (string-match-p "^Power N/A" (battery))   ; On laptops...
  (display-battery-mode 1))                       ; it's nice to know how much power you have

(defun nolinum ()
  (global-linum-mode 0)
)

(setq org-directory "~/.org"
      org-gtd-directory "~/.org/gtd/"
      org-roam-directory "~/.org"
      org-mobile-inbox-for-pull "~/.org/gtd/inbox.org"
      org-mobile-directory "~/Dropbox/Apps/MobileOrg"
      org-tag-alist '(("@calls" . ?c)
                      ("@englishscore" . ?e)
                      ("@Elen" . ?E)
                      ("@JM" . ?j)
                      ("@home" . ?h)
                      ("@mobile" . ?m)
                      ("@out" . ?o)
                      (:newline)
                      ("project" . ?p)
                      ("CANCELLED" . ?C)))

(org-roam-db-autosync-mode)
(load-file "~/.doom.d/my-gtd/my-gtd.el")
(use-package! org-edna)
;; org
(use-package! org
  :config
  (setq org-edna-use-inheritance t
        org-modules '(org-habit))
  (org-edna-mode 1)

)
;; For org mode


;; Org-agenda
(use-package! org-agenda
  :init
  (map! "C-c a" 'org-gtd-agenda)
  (defun org-gtd-agenda ()
    (interactive)
    (org-agenda nil " "))
  (setq left-margin-width 0)
  (setq right-margin-width 0)
  :config
  (setq org-agenda-files `(,org-gtd-directory))
  (setq org-capture-templates
      `(("i" "Inbox"
         entry (file ,(org-gtd-inbox-path))
         "* TODO %?\n%U\n\n  %i"
         :kill-buffer t)
        ("c" "Org-protocol capture"
         entry  (file ,(org-gtd-inbox-path))
        ,(concat "* TODO %a\n" "/Entered on/ %U")
        )))

  (setq org-agenda-property-list '("DELEGATED_TO"))
  (setq org-gtd-process-item-hooks '(org-set-tags-command org-set-effort org-priority))
  (setq org-agenda-custom-commands `((" " "Agenda"
                                      ((agenda ""
                                               ((org-agenda-span 'week)
                                                (org-deadline-warning-days 365)))
                                       (alltodo "TODO"
                                             ((org-agenda-overriding-header "Inbox")
                                              (org-agenda-files `(,(expand-file-name "gtd/inbox.org" org-directory)))))
                                       (alltodo "TODO"
                                             ((org-agenda-overriding-header "Actions")
                                              (org-agenda-files `(,(expand-file-name "gtd/actionable.org" org-directory)))))
                                       (todo "TODO"
                                             ((org-agenda-overriding-header "Incubate")
                                              (org-agenda-files `(,(expand-file-name "gtd/incubate.org" org-directory))))
                                             )))
                                     ("n" "Next" ((tags-todo "+PRIORITY=\"A\" +TODO=\"NEXT\"")))
                                     ("e" "Elen" ((tags-todo "@Elen")))
                                     )
        )
  )
(use-package! org-roam
  :config
  (setq org-roam-directory "~/.org/roam"
        org-roam-dailies-capture-templates
      '(("d" "default" entry "* %<%I:%M %p>: %?"
         :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))
  )

(defun jack/eval-buffer-in-side-window ()
  (interactive)
  (delete-other-windows)
  (split-window-right -100)
  (select-window (next-window))
  (eval-buffer)
  (select-window (next-window)))


(defun jack/capture-to-inbox ()
    (interactive)
    (org-capture nil "i"))

(defun jack/open-config-file()
    (interactive)
    (progn "hello again")
    (+ 1 1))

(map! "C-c i" 'org-gtd-process-inbox)
;; (map! "SPC m z" 'org-babel-execute-src-block)
(map! "C-c j" 'org-gtd-archive-complete-projects)
(map! "C-c d" 'org-gtd-archive-done-actions)

(map! "C-c k" 'jack/capture-to-inbox)
(map! "C-c b" 'org-babel-execute-src-block)
(map! "C-c e" 'jack/eval-buffer-in-side-window)
;;(map! "SPC " 'jack/open-config-file)


(with-eval-after-load 'writeroom-mode
  (define-key writeroom-mode-map (kbd "C-M-<") #'writeroom-decrease-width)
  (define-key writeroom-mode-map (kbd "C-M->") #'writeroom-increase-width)
  (define-key writeroom-mode-map (kbd "C-M-=") #'writeroom-adjust-width))

(add-hook! writeroom-mode
  (setq line-spacing 0.2)

  )

(defun custom-org-hook ()
  (writeroom-mode nil)
  (mixed-pitch-mode 1)
  (message "Custom Org Hook activated."))

(add-hook 'org-mode-hook
          'custom-org-hook)
