;; Shortcuts
(defun load-init ()
  (interactive)
  (find-file "~/.emacs.d/init.el")
  )

;;; init.el -*- lexical-binding: t; -*-
;;
;; Author:  Jack Bicknell <jackbicknell@gmail.com>
;; URL:     https://github.com/jackbicknell14

;; PythonWhiskey
;; 1. Initial Setup

;; MELPA Package Support

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
;; If there are no archived package contents, refresh them
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(projectile
    use-package
    elpy
    evil
    exec-path-from-shell
    pyenv-mode
    counsel
    magit
    zoom
    dashboard
    zenburn-theme
    material-theme))
;; Scans the list in myPackages
;; If the package listed is not already installed, install it
(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)


;; Appearance
(tool-bar-mode -1) 
(scroll-bar-mode -1)
(setq inhibit-startup-message t)  
(load-theme 'zenburn t)
(global-linum-mode t)
(add-to-list 'default-frame-alist '(font . "Monaco 14"))
(add-to-list 'default-frame-alist '(right-divider-width . 1))
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(set-face-attribute 'default t :font "Monaco 14" )


;; IVY - File finder

(require 'ivy)
(ivy-mode 1)

;;Ivy config
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")

(global-set-key (kbd "C-s") 'swiper-isearch)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "<f2> j") 'counsel-set-variable)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
(global-set-key (kbd "C-c v") 'ivy-push-view)
(global-set-key (kbd "C-c V") 'ivy-pop-view)

;;PROJECTILE - Project manager

;; Dependencies:
   ;; brew install fd
   ;;brew install ag

(require 'projectile)
(projectile-mode +1)
(setq projectile-project-search-path '("~/sandboxes/"))
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(setq projectile-completion-system 'ivy)
(setq projectile-find-dir-includes-top-level t)

;; EVIL - Vim for Emacs

(require 'evil)
(evil-mode 1)


;; Pyenv-Mode
(require 'pyenv-mode)
(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)
(pyenv-mode)

;; ELPY - Python for emacs
(require 'elpy)
(elpy-enable)









;; Hooks

;; Pyenv and projectile

(defun projectile-pyenv-mode-set ()
  "Set pyenv version matching project name."
  (let ((project (projectile-project-name)))
    (if (member project (pyenv-mode-versions))
        (pyenv-mode-set project)
      (pyenv-mode-unset))))

(defun horizontally-n (num)
  (if (<= num 2)
      (split-window-horizontally)
    (split-window-horizontally
     (- (window-width) (/ (window-width) num)))
    (horizontally-n (- num 1))))

(defun main-horizontally-n (num)
  (if (<= num 2)
      (split-window-horizontally
       (floor (* (window-width) (/ 2.0 3.0))))
    (split-window-vertically)
    (other-window 1)
    (horizontally-n (- num 1))))

(defun main-horizontal ()
  (switch-to-buffer "*scratch*")
  (main-horizontally-n 4)
  (other-window 3)
  (enlarge-window 5)
  (shell)
  (other-window 4)
  (delete-window)
  )

(add-hook 'projectile-after-switch-project-hook 'projectile-pyenv-mode-set)

(setq projectile-switch-project-action 'main-horizontal)

;; Start up commands

(load-init)
(require 'dashboard)
;; Set the title
(setq dashboard-banner-logo-title "WhiskeyEmacs")
;; Set the banner
(setq dashboard-startup-banner 'logo)
;; Value can be
;; 'official which displays the official emacs logo
;; 'logo which displays an alternative emacs logo
;; 1, 2 or 3 which displays one of the text banners
;; "path/to/your/image.png" or "path/to/your/text.txt" which displays whatever image/text you would prefer

;; Content is not centered by default. To center, set
(setq dashboard-center-content t)

(setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)
                        (agenda . 5)
                        (registers . 5)))

;; To disable shortcut "jump" indicators for each section, set
(setq dashboard-show-shortcuts nil)
(dashboard-setup-startup-hook)
;;;; End of WhiskeyPython ;;;;;;;

















(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(dashboard zoom zenburn-theme use-package pyenv-mode-auto projectile material-theme magit exec-path-from-shell evil elpy counsel)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
