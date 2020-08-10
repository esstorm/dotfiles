;;; ~/.config/doom/config.el -*- lexical-binding: t; -*-

;(setq user-full-name "Esteban Torres"
      ;user-mail-address "esteban.torres@ericsson.com"
(setq
      ;; doom-scratch-initial-major-mode 'lisp-interaction-mode
      doom-theme 'doom-material
      ;; treemacs-width 22


      ;; Line numbers are pretty slow all around. The performance boost of
      ;; disabling them outweighs the utility of always keeping them on.
      ;; display-line-numbers-type nil

      ;; IMO, modern editors have trained a bad habit into us all: a burning
      ;; need for completion all the time -- as we type, as we breathe, as we
      ;; pray to the ancient ones -- but how often do you *really* need that
      ;; information? I say rarely. So opt for manual completion:
      ;; company-idle-delay nil

      ;; lsp-ui-sideline is redundant with eldoc and much more invasive, so
      ;; disable it by default.
      lsp-ui-sideline-enable nil
      lsp-enable-symbol-highlighting nil)

;;
;;; UI

;; "monospace" means use the system default. However, the default is usually two
;; points larger than I'd like, so I specify size 12 here.
(setq doom-font (font-spec :family "SF Mono" :size 18 :weight 'semi-light))

;; Prevents some cases of Emacs flickering
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))


;;
;;; Keybinds

(map! :n [tab] (general-predicate-dispatch nil
                 (and (featurep! :editor fold)
                      (save-excursion (end-of-line) (invisible-p (point))))
                 #'+fold/toggle
                 (fboundp 'evil-jump-item)
                 #'evil-jump-item)
      :v [tab] (general-predicate-dispatch nil
                 (and (bound-and-true-p yas-minor-mode)
                      (or (eq evil-visual-selection 'line)
                          (not (memq (char-after) (list ?\( ?\[ ?\{ ?\} ?\] ?\))))))
                 #'yas-insert-snippet
                 (fboundp 'evil-jump-item)
                 #'evil-jump-item)
      :leader
      "h L" #'global-keycast-mode
      "f t" #'find-in-dotfiles
      "f T" #'browse-dotfiles
      "f n" #'find-in-orgnotes
      "f N" #'browse-orgnotes)


;;
;;; Modules

;; I prefer search matching to be ordered; it's more precise
(add-to-list 'ivy-re-builders-alist '(counsel-projectile-find-file . ivy--regex-plus))

;; I don't need the menu. I know all the shortcuts.
;; (remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)

;; Switch to the new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)

;; Silence all that useless output
(setq direnv-always-show-summary nil)

;; Set plantuml path
(setq plantuml-jar-path "~/bin/plantuml.jar")
(setq org-plantuml-jar-path "~/bin/plantuml.jar")

;;; :tools magit
;(setq magit-repository-directories '(("~/projects" . 2))
      ;magit-save-repository-buffers nil
      ;;; Don't restore the wconf after quitting magit, it's jarring
      ;magit-inhibit-save-previous-winconf t
      ;transient-values '((magit-commit "--gpg-sign=5F6C0EA160557395")
                         ;(magit-rebase "--autosquash" "--gpg-sign=5F6C0EA160557395")
                         ;(magit-pull "--rebase" "--gpg-sign=5F6C0EA160557395")))

;;; :lang org
;; (setq org-directory "~/notes/org"
;;       ;org-archive-location (concat org-directory ".archive/%s::")
;;       ;org-roam-directory (concat org-directory "notes/")
;;       org-journal-encrypt-journal t
;;       org-ellipsis " ▼ ")

;; :lang org
(setq org-directory "~/org"
      ;; org-archive-location (concat org-directory ".archive/%s::")
      ;; org-roam-directory (concat org-directory "notes/")
      org-journal-encrypt-journal t
      org-journal-file-format "%Y%m%d.org"
      org-ellipsis " ▼ ")

;; Patch up the evil-org key map, so that org is usable with daemon
;; https://github.com/hlissner/doom-emacs/issues/1897
(after! evil-org
  (evil-define-key '(normal visual) evil-org-mode-map
    (kbd "TAB") 'org-cycle))


;; (after! org-superstar
;;   (setq org-superstar-headline-bullets-list '("◉" "○" "✸" "✿" "✤" "✜" "◆" "▶")
;;         ;; org-superstar-headline-bullets-list '("Ⅰ" "Ⅱ" "Ⅲ" "Ⅳ" "Ⅴ" "Ⅵ" "Ⅶ" "Ⅷ" "Ⅸ" "Ⅹ")
;;         org-superstar-prettify-item-bullets t ))

;; ;;;
;; (setq projectile-project-search-path '("/repo/ezalees/vsbg"))

;(add-hook 'org-mode-hook #'+org-pretty-mode)


;; EXPERIMENTAL BEGIN
;; (add-hook! 'org-mode-hook #'+org-pretty-mode #'mixed-pitch-mode)
;; (setq global-org-pretty-table-mode t)
;; (custom-set-faces!
;;   '(outline-1 :weight extra-bold :height 1.25)
;;   '(outline-2 :weight bold :height 1.15)
;;   '(outline-3 :weight bold :height 1.12)
;;   '(outline-4 :weight semi-bold :height 1.09)
;;   '(outline-5 :weight semi-bold :height 1.06)
;;   '(outline-6 :weight semi-bold :height 1.03)
;;   '(outline-8 :weight semi-bold)
;;   '(outline-9 :weight semi-bold))
;; (after! org
;;   (custom-set-faces!
;;     '(org-document-title :height 1.2)))

;; (after! org-superstar
;;   (setq org-superstar-headline-bullets-list '("◉" "○" "✸" "✿" "✤" "✜" "◆" "▶")
;;         ;; org-superstar-headline-bullets-list '("Ⅰ" "Ⅱ" "Ⅲ" "Ⅳ" "Ⅴ" "Ⅵ" "Ⅶ" "Ⅷ" "Ⅸ" "Ⅹ")
;;         org-superstar-prettify-item-bullets t ))
;; (after! org
;;   (setq org-ellipsis " ▾ "
;;         org-priority-highest ?A
;;         org-priority-lowest ?E
;;         org-priority-faces
;;         '((?A . 'all-the-icons-red)
;;           (?B . 'all-the-icons-orange)
;;           (?C . 'all-the-icons-yellow)
;;           (?D . 'all-the-icons-green)
;;           (?E . 'all-the-icons-blue))))

;; (after! org
;;   (appendq! +pretty-code-symbols
;;             `(:checkbox      "☐"
;;               :pending       "◼"
;;               :checkedbox    "☑"
;;               :list_property "∷"
;;               :results       "🠶"
;;               :property      "☸"
;;               :properties    "⚙"
;;               :end           "∎"
;;               :options       "⌥"
;;               :title         "𝙏"
;;               :subtitle      "𝙩"
;;               :author        "𝘼"
;;               :date          "𝘿"
;;               :latex_header  "⇥"
;;               :latex_class   "🄲"
;;               :beamer_header "↠"
;;               :begin_quote   "❮"
;;               :end_quote     "❯"
;;               :begin_export  "⯮"
;;               :end_export    "⯬"
;;               :priority_a   ,(propertize "⚑" 'face 'all-the-icons-red)
;;               :priority_b   ,(propertize "⬆" 'face 'all-the-icons-orange)
;;               :priority_c   ,(propertize "■" 'face 'all-the-icons-yellow)
;;               :priority_d   ,(propertize "⬇" 'face 'all-the-icons-green)
;;               :priority_e   ,(propertize "❓" 'face 'all-the-icons-blue)
;;               :em_dash       "—"))
;;   (set-pretty-symbols! 'org-mode
;;     :merge t
;;     :checkbox      "[ ]"
;;     :pending       "[-]"
;;     :checkedbox    "[X]"
;;     :list_property "::"
;;     :results       "#+RESULTS:"
;;     :property      "#+PROPERTY:"
;;     :property      ":PROPERTIES:"
;;     :end           ":END:"
;;     :options       "#+OPTIONS:"
;;     :title         "#+TITLE:"
;;     :subtitle      "#+SUBTITLE:"
;;     :author        "#+AUTHOR:"
;;     :date          "#+DATE:"
;;     :latex_class   "#+LATEX_CLASS:"
;;     :latex_header  "#+LATEX_HEADER:"
;;     :beamer_header "#+BEAMER_HEADER:"
;;     :begin_quote   "#+BEGIN_QUOTE"
;;     :end_quote     "#+END_QUOTE"
;;     :begin_export  "#+BEGIN_EXPORT"
;;     :end_export    "#+END_EXPORT"
;;     :priority_a    "[#A]"
;;     :priority_b    "[#B]"
;;     :priority_c    "[#C]"
;;     :priority_d    "[#D]"
;;     :priority_e    "[#E]"
;;     :em_dash       "---"))
;; (plist-put +pretty-code-symbols :name "⁍") ; or › could be good?


;; EXPERIMENTAL END
;;

;; (after! org
;;   (add-to-list 'org-modules 'org-habit t))

;; (setq org-publish-project-alist
;;   '(("html"
;;      :base-directory "~/notes/org/"
;;      :base-extension "org"
;;      :publishing-directory "~/notes/org/exports"
;;      :publishing-function org-publish-org-to-html)
;;     ("pdf"
;;      :base-directory "~/notes/org/"
;;      :base-extension "org"
;;      :publishing-directory "~/notes/org/exports"
;;      :publishing-function org-publish-org-to-pdf)
;;     ("all" :components ("html" "pdf"))))

;;; :ui doom-dashboard
(setq fancy-splash-image (concat doom-private-dir "splash.png"))

;;; :ui modeline
;; (custom-set-faces!
;;   `(doom-modeline-bar-inactive :background ,(face-background 'mode-line-inactive)))

;; (use-package! keypression
;;   :defer t
;;   :config
;;   (setq ;;keypression-use-child-frame nil
;;         keypression-fade-out-delay 1.0
;;         keypression-frame-justify 'keypression-left-justified
;;         keypression-cast-command-name t
;;         keypression-cast-command-name-format "%s  %s"
;;         keypression-combine-same-keystrokes t
;;         keypression-font-face-attribute '(:width normal :height 200 :weight bold)))


;;
;;; Language customizations

(custom-set-faces!
  `(markdown-code-face :background ,(doom-darken 'bg 0.075)))
