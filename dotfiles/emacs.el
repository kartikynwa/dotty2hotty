;;; package -- Summary
;;; DOT_DEST=.emacs.d/init.el
;;; Commentary:

;;; Code:

;; who we are
(setq user-full-name "Kartik Singh")
(setq user-mail-address "kartik.ynwa@gmail.com")
(setq-default frame-title-format '("%b [%m]"))
(setq ad-redefinition-action 'accept)

;; stop the fucking cursor from blinking
(blink-cursor-mode 0)

;; m i n i m a l
(if window-system (scroll-bar-mode -1))
(tool-bar-mode -1)
(menu-bar-mode -1)

;; display line numbers by default
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

;; font:default
(set-face-attribute 'default nil
                    :font "DejaVu Sans Mono"
                    :height 140)

;; custom file location
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file) (load custom-file 'noerror))

;; utf 8 unicode glyps for memes
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; set default column width
(setq-default fill-column 80)
(global-visual-line-mode)

;; fuck bells
(setq visible-bell nil)
(setq ring-bell-function 'ignore)

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
;;(require 'diminish)
;;(require 'bind-key)

;; rainbow
;; (use-package rainbow-mode :ensure t)
(use-package diminish :ensure t)
;; 
;; 
;; solarized-theme
(use-package solarized-theme :ensure t)

;; current line highlight
(use-package hl-line
  :config
  (add-hook 'prog-mode-hook #'hl-line-mode))

;; Gruvbox theme
(use-package gruvbox-theme
  :ensure t
  :config
  (load-theme 'gruvbox-dark-hard)
  (set-face-background hl-line-face "#282828"))

;; breaking open parentheses
(defun new-line-dwim ()
  (interactive)
  (let ((break-open-pair (or (and (looking-back "{") (looking-at "}"))
                             (and (looking-back ">") (looking-at "<"))
                             (and (looking-back "(") (looking-at ")"))
                             (and (looking-back "\\[") (looking-at "\\]")))))
    (newline)
    (when break-open-pair
      (save-excursion
        (newline)
        (indent-for-tab-command)))
    (indent-for-tab-command)))

;; smartparens mode
(use-package smartparens
  :ensure t
  :init
  (add-hook 'prog-mode-hook #'turn-on-smartparens-mode)
  :config
  (setq sp-show-pair-from-inside nil)
  (setq sp-highlight-pair-overlay nil)
  (require 'smartparens-config)
  :bind ("RET" . new-line-dwim))

;; show column number in mode line
(setq column-number-mode t)

;; change splash screen
(setq inhibit-splash-screen t
      initial-scratch-message nil)

;; evil mode 
(use-package evil
  :ensure t
  :config
  (use-package undo-tree :ensure t :diminish undo-tree-mode)
  (setq evil-want-C-u-scroll t
        ;;      evil-want-visual-char-semi-exclusive t
        ;;      evil-magic t
        ;;      evil-echo-state t
        ;;      evil-indent-convert-tabs t
        ;;      evil-ex-search-vim-style-regexp t
        ;;      evil-ex-substitute-global t
        ;;      evil-ex-visual-char-range t  ; column range for ex commands
        ;;      evil-insert-skip-empty-lines t
        ;;      evil-mode-line-format 'nil
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
  :ensure t
  :diminish evil-snipe-local-mode
  :after evil
  :init
  (evil-snipe-mode 1)
  (add-hook 'magit-mode-hook 'turn-off-evil-snipe-override-mode))

(use-package hydra
  :ensure t
  :config
  (defhydra hydra-evil-window-resize ()
    "hydra-evil-window-resize"
    ("j" evil-window-decrease-height "window-decrease-height")
    ("k" evil-window-increase-height "window-increase-height")
    ("h" evil-window-decrease-width "window-decrease-width")
    ("l" evil-window-increase-width "window-increase-width"))
  (defun evil-window-resize-hydra ()
    "resize evil window"
    (interactive)
    (hydra-evil-window-resize/body))
  (defhydra hydra-text-scale ()
    "hydra-text-scale"
    ("=" (text-scale-adjust 0) "text-scale-adjust")
    ("-" text-scale-decrease "text-scale-decrease")
    ("+" text-scale-increase "text-scale-increase"))
  (defun text-scale-hydra ()
    "text scale hydra"
    (interactive)
    (hydra-text-scale/body))
  (defhydra hydra-spell ()
    "hydra-spell"
    ("f" flyspell-buffer "flyspell-buffer")
    ("n" flyspell-goto-next-error "flyspell-goto-next-error")
    ("c" ispell-word "ispell-word"))
  (defun spell-check-hydra ()
    "goto next error and initiate hydra body"
    (interactive)
    (hydra-spell/body)))
 
(use-package general
  :ensure t
  :config
  (general-define-key "M-SPC" nil)
  (general-define-key "C-SPC" nil)
  (general-define-key :prefix "SPC"
                      :non-normal-prefix "M-SPC"
                      :states '(normal visual emacs)
                      "/" 'counsel-find-file
                      ":" 'counsel-M-x
                      "," 'switch-to-buffer
                      "w" 'evil-window-map
                      "p" 'projectile-command-map
                      "." 'projectile-find-file
                      "x" 'kill-current-buffer
                      ;;                    "g" 'magit-status
                      "c" 'spell-check-hydra
                      "z" 'text-scale-hydra
                      "d" 'define-word-at-point
                      "D" 'define-word
                      "s" 'swiper
                      "r" 'evil-window-resize-hydra
                      "h" 'evil-window-left
                      "j" 'evil-window-down
                      "k" 'evil-window-up
                      "l" 'evil-window-right
                      "n" 'neotree-toggle)
  (general-define-key :prefix "C-c"
                      :states '(normal visual motion insert emacs)
                      "a" 'org-agenda)
  (general-define-key :states '(visual emacs)
                      "M-c" 'clipboard-kill-ring-save)
  (general-define-key :states '(insert)
                      "C-SPC" 'company-complete
                      "M-v"   'clipboard-yank)
  (general-define-key :keymaps 'neotree-mode-map
                      :states 'normal
                      "RET" 'neotree-enter
                      "q" 'neotree-hide
                      [tab] 'neotree-quick-look))
;; 
;; disable backups
(setq-default make-backup-files nil) ; stop creating backup~ files
(setq-default auto-save-default nil) ; stop creating #autosave# files

;; spell check
(setq ispell-dictionary "en_GB")
(setq ispell-personal-dictionary "~/.emacs.d/ispell_personal_dictionary")

;; langtool mode (requires package LanguageTool)
(use-package langtool
  :ensure t
  :config
  (setq langtool-java-classpath "/usr/share/languagetool:/usr/share/java/languagetool/*")
  (setq langtool-default-language "en-GB"))

;; fuck tabs
(setq-default c-basic-offset 2)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; neotree
(use-package neotree
  :ensure t
  :config (setq neo-theme 'ascii))


;; AUCTeX
(use-package auctex
  :ensure t
  :defer t)

;; org-mode tweaks
(use-package wc-mode
  :ensure t)

(setq org-agenda-files (quote ("~/orgy/todo.org")))

(use-package org
  :config
  (setq-default org-ellipsis "  "
                org-startup-folded t
                org-startup-indented t
                org-hide-leading-stars t
                org-hide-leading-stars-before-indent-mode t
                org-latex-packages-alist '(("margin=2cm" "geometry" nil))
                org-image-actual-width nil
                org-indent-indentation-per-level 2
                org-indent-mode-turns-on-hiding-stars t
                org-export-with-toc nil
                org-todo-keywords '((sequence "TODO(t)" "|" "DONE(d)")
                                    (sequence "IDEA(i)" "NEXT(n)" "ACTIVE(a)" "WAITING(w)" "LATER(l)" "|" "CANCELLED(c)")))
  (custom-set-faces '(org-todo ((t (:box nil))))
                    '(org-done ((t (:box nil))))
                    '(org-checkbox ((t (:box nil :foreground nil :background nil)))))
  (use-package org-bullets
    :ensure t
    :defines org-bullets-bullet-list
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

;; ivy-mode
(use-package ivy
  :ensure t
  :diminish ivy-mode
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

;; haskell mode
(use-package haskell-mode :ensure t)

;; emacs speaks statistics
(use-package ess
  :ensure t
  :init (require 'ess-site))

;; racket mode
(use-package racket-mode :ensure t)

;; rust mode
(use-package rust-mode :ensure t)

;; writeroom settings
(use-package writeroom-mode
  :ensure t
  :config
  (setq-default writeroom-fullscreen-effect nil)
  (add-hook 'text-mode-hook #'writeroom-mode))

;; nov.el mode
(use-package nov
  ;; :ensure t
  :config
  ;; (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
  (setq nov-variable-pitch nil)
  (setq nov-text-width 80))

;; define-word
(use-package define-word
  :ensure t)

;; focus-mode
(use-package focus
  :ensure t)

(use-package visual-fill-column :ensure t)

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
  :diminish company-mode
  :defines company-dabbrev-downcase
  :config
  (setq company-idle-delay nil
        company-tooltip-limit 10
        company-tooltip-align-annotations t)
  (add-hook 'prog-mode-hook 'company-mode))

;; yasnippets
(use-package yasnippet
  :ensure t
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/yasnippet-snippets/snippets"))
  (yas-global-mode 1))
 
;; projectile
(use-package projectile
  :ensure t
  :config
  (setq projectile-completion-system 'ivy)
  (projectile-mode))
 
;; ;; == magit ==
;; (use-package magit
;;   :ensure t
;;   :defer t
;;   :bind ("C-x g" . magit-status)
;;   :init
;;   (setq magit-diff-refine-hunk 'all)
;;   ;; Use evil keybindings within magit
;;   :config
;;   (use-package evil-magit
;;     :config
;;     ;; Default commit editor opening in insert mode
;;     (add-hook 'with-editor-mode-hook 'evil-insert-state)
;;     (evil-define-key 'normal with-editor-mode-map
;;       (kbd "RET") 'with-editor-finish
;;       [escape] 'with-editor-cancel
;;       )
;;     (evil-define-key 'normal git-rebase-mode-map
;;       "l" 'git-rebase-show-commit)))
;; 
;; ;; == flycheck ==
;; (use-package flycheck
;;   :ensure t
;;   :diminish flycheck-mode
;;   :init
;;   (add-hook 'after-init-hook #'global-flycheck-mode)
;;   ;; check OS type
;;   (if (string-equal system-type "gnu/linux")
;;       (progn
;;         (custom-set-variables
;;          '(flycheck-c/c++-clang-executable "clang-3.5")
;;          )))
;;   (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-gcc)))
;; 
;; which-key shows promt that tells what keystrokes do. reallly neat.
(use-package which-key
  :ensure t
  :diminish which-key-mode
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

;; web mode indents
;;(defun setup-web-indent (n)
;;   web development
;;  (setq-local coffee-tab-width n)              ; coffeescript
;;  (setq-local javascript-indent-level n)       ; javascript-mode
;;  (setq-local js-indent-level n)               ; js-mode
;;  (setq-local js2-basic-offset n)              ; js2-mode, in latest js2-mode, it's alias of js-indent-level
;;  (setq-local web-mode-markup-indent-offset n) ; web-mode, html tag in html file
;;  (setq-local web-mode-css-indent-offset n)    ; web-mode, css in html file
;;  (setq-local web-mode-code-indent-offset n)   ; web-mode, js code in html file
;;  (setq-local css-indent-offset n)             ; css-mode
;;  (setq-local web-mode-script-padding n)       ;
;;  (setq-local web-mode-style-padding n)        ; some kinda paddings haha
;;  (setq-local web-mode-block-padding n))       ; 

(defun web-indent ()
  (setup-web-indent 2))


;; web-mode (wth lol)
(use-package web-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
  (setq-default coffee-tab-width 2)              ; coffeescript
  (setq-default javascript-indent-level 2)       ; javascript-mode
  (setq-default js-indent-level 2)               ; js-mode
  (setq-default js2-basic-offset 2)              ; js2-mode, in latest js2-mode, it's alias of js-indent-level
  (setq-default web-mode-markup-indent-offset 2) ; web-mode, html tag in html file
  (setq-default web-mode-css-indent-offset 2)    ; web-mode, css in html file
  (setq-default web-mode-code-indent-offset 2)   ; web-mode, js code in html file
  (setq-default css-indent-offset 2)             ; css-mode
  (setq-default web-mode-script-padding 2)       ;
  (setq-default web-mode-style-padding 2)        ; some kinda paddings haha
  (setq-default web-mode-block-padding 2))       ; 
(add-hook 'web-mode-hook 'web-indent)

;; open todo file
(defun todo-at-startup ()
  "Opens the todo file which has things that need to be done but probably won't be."
  (find-file "~/orgy/todo.org"))
 
;; open todo file at startup
(add-hook 'emacs-startup-hook #'todo-at-startup)
 
(provide 'init)
;;; init.el ends here
