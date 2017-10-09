;;; package -- Summary
;;;PATH=.emacs.d/init.el
;;; Commentary:

;;; Code:

;; who we are
(setq user-full-name "Kartik Singh")
(setq user-mail-address "kartik.ynwa@gmail.com")


(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default)))
 '(flycheck-c/c++-clang-executable "clang-3.5")
 '(package-selected-packages
   (quote
    (nlinum general counsel highlight-parentheses evil-snipe evil-surround evil-magit flycheck magit olivetti smart-mode-line markdown-mode ivy evil undo-tree solarized-theme use-package))))

;; font:default
(set-face-attribute 'default nil
                    :font "Consolas"
                    :height 140)

;; set default column width
(setq-default fill-column 80)

;; fuck bells
(setq visible-bell nil)
(setq ring-bell-function 'ignore)

;; m i n i m a l
(if window-system (scroll-bar-mode -1))
(tool-bar-mode -1)
(menu-bar-mode -1)

;; solarized-theme
(use-package solarized-theme
  :ensure t
  :config
  (setq solarized-use-variable-pitch nil)
  (setq solarized-use-less-bold t)
  (setq x-underline-at-descent-line t)
  (load-theme 'solarized-light)
  (set-face-attribute 'show-paren-match nil :foreground "#fdf6e3" :background "#586e75"))

;; current line highlight
(use-package hl-line
  :config
  (global-hl-line-mode 1))
  

;; show column number in mode line
(setq column-number-mode t)

;; change splash screen
(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'markdown-mode)

;; evil mode - i am not sure how undo-tree works so I will just install it
;; beforehand
(use-package evil
  :ensure t
  :config
  (use-package undo-tree :ensure t)
  (setq evil-want-C-u-scroll t
        evil-want-visual-char-semi-exclusive t
        evil-magic t
        evil-echo-state t
        evil-indent-convert-tabs t
        evil-ex-search-vim-style-regexp t
        evil-ex-substitute-global t
        evil-ex-visual-char-range t  ; column range for ex commands
        evil-insert-skip-empty-lines t
        evil-mode-line-format 'nil
        ;; more vim-like behavior
        evil-symbol-word-search t
        ;; don't activate mark on shift-click
        shift-select-mode nil)
  (evil-mode 1))

(use-package evil-surround
  :ensure t
  :after evil
  :init
  (global-evil-surround-mode 1))

(use-package evil-snipe
  :diminish evil-snipe-local-mode
  :ensure t
  :after evil
  :init
  (evil-snipe-mode 1)
  (add-hook 'magit-mode-hook 'turn-off-evil-snipe-override-mode))

(use-package general
  :ensure t
  :config
  (general-define-key "M-SPC" nil)
  (general-define-key :prefix "SPC"
                      :non-normal-prefix "M-SPC"
                      :states '(normal visual motion insert emacs)
                      "/" 'counsel-find-file
                      ":" 'counsel-M-x
                      "," 'switch-to-buffer
                      "w" 'evil-window-map
                      "p" 'projectile-command-map
                      "." 'projectile-find-file
                      "x" 'kill-buffer
                      "g" 'magit-status
                      "s" 'swiper
                      "h" 'evil-window-left
                      "j" 'evil-window-down
                      "k" 'evil-window-up
                      "l" 'evil-window-right)
  (general-define-key :states '(visual emacs)
                      "M-c" 'clipboard-kill-ring-save)
  (general-define-key :keymaps 'global
                      "M-v" 'clipboard-yank))

;; disable backups
(setq-default make-backup-files nil) ; stop creating backup~ files
(setq-default auto-save-default nil) ; stop creating #autosave# files

;; fuck tabs
(setq-default c-basic-indent 2)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

;; org-mode tweaks
(use-package org
  :config
  (setq-default org-ellipsis "  "
                org-startup-folded t
                org-startup-indented t
                org-hide-leading-stars t
                org-hide-leading-stars-before-indent-mode t
                org-latex-packages-alist '(("margin=2cm" "geometry" nil))
                org-image-actual-width nil
                org-indent-indentation-per-level 2
                org-indent-mode-turns-on-hiding-stars t
                org-todo-keywords '((sequence "[ ](t)" "[-](p)" "[?](m)" "|" "[X](d)")
                                    (sequence "TODO(T)" "|" "DONE(D)")
                                    (sequence "IDEA(i)" "NEXT(n)" "ACTIVE(a)" "WAITING(w)" "LATER(l)" "|" "CANCELLED(c)")))
  (custom-set-faces '(org-todo ((t (:box nil))))
                    '(org-done ((t (:box nil))))
                    '(org-checkbox ((t (:box nil :foreground nil :background nil)))))
  (use-package org-bullets
    :ensure t
    :init (add-hook 'org-mode-hook #'org-bullets-mode)
    :config (setq org-bullets-bullet-list '("#"))))

(defun my/org-mode-hook ()
  "Stop the org-level headers from increasing in height relative to the other text."
  (dolist (face '(org-level-1
                  org-level-2
                  org-level-3
                  org-level-4
                  org-level-5
                  org-document-title))
    (set-face-attribute face nil :weight 'semi-bold :height 1.0)))

(add-hook 'org-mode-hook 'my/org-mode-hook)

;; ivy-mode
(use-package ivy
  :ensure t
  :init
  (use-package counsel :ensure t)
  (use-package swiper :ensure t)
  :bind
  (("M-x" . counsel-M-x)
   ("\C-s" . swiper)
   ("C-x C-f" . counsel-find-file))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t))

;; markdown mode
(use-package markdown-mode :ensure t)

;; olivetti settings
(use-package olivetti
  :ensure t
  :config
  (setq-default olivetti-body-width 90))

;; prose mode for prose
(defun prose! ()
  "I don't want no distraction, m8."
  (interactive)
  (turn-on-auto-fill)
  (olivetti-mode 1))

(add-hook 'text-mode-hook 'prose!)

;; scrolling hax
(use-package smooth-scrolling
  :disabled t
  :config
  (smooth-scrolling-mode t))

;; parentheses highlighting
(use-package paren
  :init
  (add-hook 'prog-mode-hook #'show-paren-mode))
(use-package highlight-parentheses
  :ensure t
  :diminish 'highlight-parentheses-mode
  :init
  (add-hook 'prog-mode-hook #'highlight-parentheses-mode)
  :config
  (set-face-attribute 'hl-paren-face nil :underline t))

;; company mode code completion
(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  (use-package company-irony :ensure t :defer t)
  (setq company-idle-delay              nil
        company-minimum-prefix-length   2
        company-show-numbers            t
        company-tooltip-limit           20)
  :diminish company-mode
  :bind
  ("C-;" . company-complete-common)
  ("C-SPC" . company-complete-common))

;; projectile
(use-package projectile
  :ensure t
  :config
  (setq projectile-completion-system 'ivy)
  (projectile-mode))

;; == magit ==
(use-package magit
  :ensure t
  :defer t
  :bind ("C-x g" . magit-status)
  :init
  (setq magit-diff-refine-hunk 'all)
  ;; Use evil keybindings within magit
  :config
  (use-package evil-magit
    :ensure t
    :config
    ;; Default commit editor opening in insert mode
    (add-hook 'with-editor-mode-hook 'evil-insert-state)
    (evil-define-key 'normal with-editor-mode-map
      (kbd "RET") 'with-editor-finish
      [escape] 'with-editor-cancel
      )
    (evil-define-key 'normal git-rebase-mode-map
      "l" 'git-rebase-show-commit)))

;; == flycheck ==
(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :init
  (add-hook 'after-init-hook #'global-flycheck-mode)
  ;; check OS type
  (if (string-equal system-type "gnu/linux")
      (progn
        (custom-set-variables
         '(flycheck-c/c++-clang-executable "clang-3.5")
         )))
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-gcc)))

;; which-key shows promt that tells what keystrokes do. reallly neat.
(use-package which-key
  :ensure t
  :config
  (setq which-key-sort-order #'which-key-prefix-then-key-order
        which-key-sort-uppercase-first nil
        which-key-add-column-padding 1
        which-key-max-display-columns nil
        which-key-min-display-lines 5)
  ;; embolden local bindings
  (set-face-attribute 'which-key-local-map-description-face nil :weight 'bold)
  (which-key-setup-side-window-bottom)
  (add-hook 'after-init-hook #'which-key-mode))

;; nlinum - show line numbers
(use-package nlinum
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'nlinum-mode))

;; open todo file
(defun todo! ()
  "Opens the todo file which has things that need to be done but probably won't be."
  (interactive)
  (find-file "~/orgy/todo.org")
  (outline-show-all))

;; open todo file at startup
(todo!)

(provide 'init)
;;; init.el ends here
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-checkbox ((t (:box nil :foreground nil :background nil))))
 '(org-done ((t (:box nil))))
 '(org-todo ((t (:box nil)))))
