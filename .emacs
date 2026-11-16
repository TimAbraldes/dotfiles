;; -*- lexical-binding: t; -*-
;; The above is necessary to avoid warnings on every launch.
;; It is the "lexical-binding cookie" and signifies maybe that lexical binding should be used instead of dynamic binding?
;; It also needs to be the first thing in this file so don't place anything above it (including these comments)

;; ---------------------------------------------------------------------------
;; This block was synthesized from the following sets of instructions:
;; https://github.com/emacs-evil/evil
;; https://elpa.gnu.org/packages/doc/auctex.html#Installation
;;
;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

;; use-package will load the package if it is not already loaded, and :ensure means that it will download if not already present
(use-package evil
  :ensure t)
(use-package auctex
  :ensure t)

;; Enable Evil
(require 'evil)
(evil-mode 1)
(evil-set-undo-system 'undo-redo)
;; ---------------------------------------

;; ---------------------------------------
;; This block was added automatically
;; =======================================
;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(modus-vivendi))
 '(display-line-numbers t)
 '(global-whitespace-mode t)
 '(inhibit-startup-screen t)
 '(package-selected-packages nil)
 '(tab-width 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
