;;; my-gtd/org-gtd-templates.el -*- lexical-binding: t; -*-


;; Templates
(defconst org-gtd-actionable-template
  "#+STARTUP: overview indent align inlineimages hidestars logdone logrepeat logreschedule logredeadline
#+TODO: NEXT(n) TODO(t) WAIT(w@) | DONE(d) CANCELED(c@)
* Actions
:PROPERTIES:
:CATEGORY: Action
:END:
* Delegated
:PROPERTIES:
:CATEGORY: Delegated
:END:
* Scheduled
:PROPERTIES:
:CATEGORY: Scheduled
:END:
* Projects
:PROPERTIES:
:TRIGGER: next-sibling todo!(NEXT)
:CATEGORY: Projects
:END:
"
  "Template for the GTD actionable list.")

(defconst org-gtd-inbox-template
  "#+STARTUP: overview hidestars logrefile indent logdone
#+TODO: NEXT TODO WAIT | DONE CANCELED TRASH
#+begin_comment
This is the inbox. Everything goes in here when you capture it.
#+end_comment
"
  "Template for the GTD inbox.")

(defconst org-gtd-incubate-template
  "#+begin_comment
Here go the things you want to think about someday. Review this file as often
as you feel the need: every two months? Every six months? Every year?
It's suggested that you categorize the items in here somehow, such as:
\"to read\", \"to buy\", \"to eat\", etc - whatever works best for your mind!
#+end_comment
* Auto-generated incubate headline
"
  "Template for the GTD someday/maybe list.")
