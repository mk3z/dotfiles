;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Matias Zwinger"
      user-mail-address "matias.zwinger@protonmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))

(setq doom-font (font-spec :family "Terminus" :size 14 :weight 'Regular)
      doom-variable-pitch-font (font-spec :family "Latin Modern Roman" :size 16 :weight 'Regular)
      doom-big-font (font-spec :family "Terminus" :size 24 :weight 'Regular))

(setq all-the-icons-scale-factor 1)

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-nord)

;; Set dashboard logo
(setq fancy-splash-image "~/.config/doom/logo.svg")

;; Emacs window opacity
(add-to-list 'default-frame-alist '(alpha . 90))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; Enable autosaving and backups
(setq auto-save-default t
      make-backup-files t)

;; Set line wrapping to 80 columns
(setq fill-column 80)

;; Disable exit confirmation
(setq confirm-kill-emacs nil)

;; Enable markdown-mode in mdx files
(add-to-list 'auto-mode-alist '("\\.mdx\\'" . markdown-mode))

(org-babel-do-load-languages
    'org-babel-load-languages
    '((mermaid . t)
      (scheme . t)))

;; Default LaTeX packages
(setq org-latex-packages-alist
      '(("" "amsthm"    t)
        ("" "forest"    t)
        ("" "mathtools" t)
        ("" "siunitx"   t)
        ("" "tikz"      t)))

;; LaTeX preview software
(setq org-preview-latex-default-process 'dvisvgm)

(setq pdf-latex-command "latexmk")

(setq evil-tex-toggle-override-m nil)

;; Modify keymap for colemak
(define-key evil-window-map "m" 'evil-window-left)
(define-key evil-window-map "M" 'evil-window-move-very-left)
(define-key evil-window-map (kbd "C-S-m") 'evil-window-move-very-left)
(define-key evil-window-map "n" 'evil-window-down)
(define-key evil-window-map "N" 'evil-window-move-very-bottom)
(define-key evil-window-map (kbd "C-S-n") 'evil-window-move-very-bottom)
(define-key evil-window-map "e" 'evil-window-up)
(define-key evil-window-map "E" 'evil-window-move-very-top)
(define-key evil-window-map (kbd "C-S-e") 'evil-window-move-very-top)
(define-key evil-window-map "i" 'evil-window-right)
(define-key evil-window-map "I" 'evil-window-move-far-right)
(define-key evil-window-map (kbd "C-S-i") 'evil-window-move-far-right)
(define-key evil-window-map "k" 'evil-window-new)
(define-key evil-window-map "\C-k" 'evil-window-new)

;; Turn on rainbow-mode
(add-hook 'prog-mode-hook 'rainbow-mode)
(add-hook 'text-mode-hook 'rainbow-mode)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind
  (("C-TAB" . 'copilot-accept-completion-by-word)
   ("C-<tab>" . 'copilot-accept-completion-by-word)
   :map copilot-completion-map
   ("<tab>" . 'copilot-accept-completion)
   ("TAB" . 'copilot-accept-completion)))

(use-package! doom-modeline
  :config
  (setq doom-modeline-icon t
        doom-modeline-major-mode-icon t
        doom-modeline-enable-word-count t))

(use-package! evil-colemak-basics
  :after evil
  :init
  (setq evil-colemak-basics-layout-mod 'mod-dh)
  :config
  (global-evil-colemak-basics-mode)
  (global-visual-line-mode 1))

(use-package! focus
  :config
  (map! :leader
      :prefix "t"
      :desc "Focus mode" "k" #'focus-mode
      :desc "Focus read only" "K" #'focus-read-only-mode))

(use-package! magit-delta
 :hook (magit-mode . magit-delta-mode))

(use-package! mixed-pitch
  :hook (org-mode . mixed-pitch-mode)
  :config
  (setq mixed-pitch-face 'variable-pitch))

(use-package ob-mermaid
  :config
  (setq ob-mermaid-cli-path "/usr/bin/mmdc"))

(use-package! org-appear
  :after org
  :hook (org-mode . org-appear-mode)
  :config
  (setq
   org-appear-autolinks t
   org-appear-autoentities t
   org-appear-autosubmarkers t))

(use-package! org-fragtog
  :after org
  :hook (org-mode . org-fragtog-mode))

(use-package! org-roam
  :config
  (setq
   org-directory "~/Documents/org/"
   org-roam-directory "~/Documents/org")
  (org-roam-db-autosync-mode))

(use-package! org-superstar
  :config
  (setq
   org-superstar-headline-bullets-list '("✹" "✷" "✶" "✦" "‣" "•")))

(use-package! projectile
  :config
  (setq
   projectile-project-search-path '("~/Code/" "~/Documents/")))

(use-package! rainbow-mode)

(use-package! writeroom-mode
  :config
  (map! :leader
        :prefix "t"
        :desc "Soft line wrapping" "W" #'+word-wrap-mode
        :desc "Writeroom mode" "w" #'writeroom-mode)
  (setq
   writeroom-mode-line t
   writeroom-global-effects
        '(writeroom-set-menu-bar-lines
          writeroom-set-tool-bar-lines
          writeroom-set-vertical-scroll-bars))
  (global-writeroom-mode))
