;; ---------------------------------------------------------------------------
;; This block was adapted from the emacs-evil installation instructions:
;; https://github.com/emacs-evil/evil
;;
;; Set up evil
;; ==================================
;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

;; Download Evil
(unless (package-installed-p 'evil)
  (package-initialize)
  (package-refresh-contents)
  (package-install 'evil)
)

;; Enable Evil
(require 'evil)
(evil-mode 1)
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
 '(inhibit-startup-screen t)
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
