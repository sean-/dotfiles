;;; init.el --- user init file
(let ((default-directory (concat user-emacs-directory
        (convert-standard-filename "lisp/"))))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))
(add-to-list 'load-path (concat (getenv "GOPATH") "/src/github.com/golang/lint/misc/emacs/"))
(add-to-list 'load-path (concat (getenv "GOPATH") "/src/golang.org/x/tools/cmd/guru/"))
(add-to-list 'load-path (concat (getenv "GOPATH") "/src/golang.org/x/tools/refactor/rename/"))
(add-to-list 'load-path (concat (getenv "GOPATH") "/src/github.com/dougm/goflymake/"))

;; BEGIN: marmalade
(require 'package)
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
;;(package-refresh-contents)

(setq load-prefer-newer t)
(package-initialize)
(require 'auto-compile)
(auto-compile-on-load-mode)
(auto-compile-on-save-mode)
;;(setq auto-compile-display-buffer nil)
;;(setq auto-compile-mode-line-counter t)

(if (file-exists-p
 (concat (getenv "TMPDIR") "emacs"
         (number-to-string
          (user-real-uid)) "/server"))
nil (server-start))

;; If something edits a buffer while we're editing it, revert to whatever is on the filesystem.
(global-auto-revert-mode t)

(setq-default fill-column 80)
(setq-default line-number-mode t)
(setq-default column-number-mode t)

;; BEGIN: auto-complete.el
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;; END: auto-complete.el

;; Enable graphviz mode
(autoload 'graphviz-dot-mode "graphviz-dot-mode" "Graphviz DOT mode." t)

;; BEGIN: filladapt
(require 'filladapt)
(setq-default filladapt-mode t)
(add-hook 'text-mode-hook 'turn-on-filladapt-mode)
;;(add-hook 'c-mode-hook 'turn-off-filladapt-mode)

;; BEGIN: clang complete
(require 'auto-complete-clang)
(setq clang-completion-suppress-error 't)

(defun my-c-mode-common-hook()
  (setq ac-auto-start nil)
  (setq ac-expand-on-auto-complete nil)
  (setq ac-quick-help-delay 0.3)
  (define-key c-mode-base-map (kbd "M-/") 'ac-complete-clang)
)

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
;; end clang complete

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'solarized t)
(set-terminal-parameter nil 'background-mode 'dark)
(setq solarized-termcolor 256)

;; All trailing whitespace needs to be highlighted so it can die.
(setq-default show-trailing-whitespace t)
(setq-default indent-tabs-mode nil)
(setq indent-tabs-mode nil)
(setq c-basic-offset 2)
(setq c-basic-indent 2)
; (setq tab-width 4)

(setq-default display-time-24hr-format t)
(display-time)

(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

;; Draw tabs with the same color as trailing whitespace
(add-hook 'font-lock-mode-hook
  (lambda ()
    (font-lock-add-keywords
      nil
      '(("\t" 0 'trailing-whitespace prepend)))))
(add-hook 'c++-mode-hook
      '(lambda()
        ;; In theory, we could place some regexes into `c-mode-common-hook'. But note that their
        ;; evaluation order matters.
        (font-lock-add-keywords
         nil '(;; complete some fundamental keywords
           ("\\<\\(void\\|unsigned\\|signed\\|char\\|short\\|bool\\|int\\|long\\|float\\|double\\)\\>" . font-lock-keyword-face)
           ;; add the new C++11 keywords
           ("\\<\\(alignof\\|alignas\\|constexpr\\|decltype\\|noexcept\\|nullptr\\|static_assert\\|thread_local\\|override\\|final\\)\\>" . font-lock-keyword-face)
           ("\\<\\(char[0-9]+_t\\)\\>" . font-lock-keyword-face)
           ;; PREPROCESSOR_CONSTANT
           ("\\<[A-Z]*_[A-Z_]+\\>" . font-lock-constant-face)
           ;; hexadecimal numbers
           ("\\<0[xX][0-9A-Fa-f]+\\>" . font-lock-constant-face)
           ;; integer/float/scientific numbers
           ("\\<[\\-+]*[0-9]*\\.?[0-9]+\\([ulUL]+\\|[eE][\\-+]?[0-9]+\\)?\\>" . font-lock-constant-face)
           ;; user-defined types (customizable)
           ("\\<[A-Za-z_]+[A-Za-z_0-9]*_\\(type\\|ptr\\)\\>" . font-lock-type-face)
           ;; some explicit typenames (customizable)
           ("\\<\\(xstring\\|xchar\\)\\>" . font-lock-type-face)
           ))
        ) t)

;;(require 'linum)
(require 'lineno)
(prefer-coding-system 'utf-8)

(require 'yaml-mode)

(setq auto-mode-alist
      (append '(
                ("Doxyfile$" . makefile-mode)
                ("Doxyfile.tmpl$" . makefile-mode)
                ("\\.[Cc][Pp][Pp]$" . c++-mode)
                ("\\.[Cc][Xx][Xx]$" . c++-mode)
                ("\\.[Hh][Xx][Xx]$" . c++-mode)
                ("\\.[Tt][Cc][Cc]$" . c++-mode)
                ("\\.conf$" . conf-mode)
                ("\\.dot$" . graphviz-dot-mode)
                ("\\.h$" . c++-mode)
                ("\\.hcl$" . hcl-mode)
                ("\\.js$" . js2-mode)
                ("\\.json$" . js2-mode)
                ("\\.l$" . flex-mode)
                ("\\.ll$" . flex-mode)
                ("\\.lua$" . lua-mode)
                ("\\.mak$" . makefile-mode)
                ("\\.php$" . php-mode)
                ("\\.rb$" . ruby-mode)
                ("\\.tf$" . terraform-mode)
                ("\\.tfvars$" . terraform-mode)
                ("\\.y$" . bison-mode)
                ("\\.y[a]?ml$" . yaml-mode)
                ("\\.yy$" . bison-mode)
                ("\\.zsh$" . sh-mode)
                ("\\CHANGES$" . text-mode)
                ("\\INSTALL$" . text-mode)
                ("\\README$" . text-mode)
                ("\\TODO$" . text-mode)
                ) auto-mode-alist))

(setq interpreter-mode-alist
      (append '(("ruby" . ruby-mode))
              interpreter-mode-alist))

(setq user-full-name "Sean Chittenden"
      user-mail-address "sean@chittenden.org"
      enable-local-variables :safe
      inhibit-startup-message t
      require-final-newline t
;      default-tab-width 4
      truncate-partial-width-windows nil
      frame-title-format (concat user-login-name "@" system-name))

(add-hook 'suspend-hook 'do-auto-save) ;; Auto-Save on ^Z

(fset 'yes-or-no-p 'y-or-n-p) ;; Make all yes-or-no questions as y-or-n

(if (file-accessible-directory-p (expand-file-name "~/.Trash"))
    (add-to-list 'backup-directory-alist
                 (cons "." (expand-file-name "~/.Trash/emacs-backups/"))))

(defun start-programing-mode()
  (interactive)

  ;; Display column numbers only in code.
  (column-number-mode t)

  ;; Setup flyspell to make me not look like an idiot to my coworkers
  ;; and Haeleth and whoever else reads my code.
  (flyspell-prog-mode)

;  (project-root-fetch)

  (lineno-minor-mode)
  ;; Highlight matching parenthesis (and other bracket likes)
  (show-paren-mode t))

;; Text files supposedly end in new lines, or they should.
(setq require-final-newline t)

;; Prevent windows from getting too small.
(setq window-min-height 3)

;; Ignore case of file completion
(setq read-file-name-completion-ignore-case t)

;; Completion ignores filenames ending in any string in this list.
(setq completion-ignored-extensions
  '(".o" ".elc" "~" ".bak" ))

;; savehist-mode
;; Mode requires customizations set prior to enabling.
(setq savehist-additional-variables
      '(search-ring regexp-search-ring)    ; Save search entries.
      savehist-file "~/.emacs.d/savehist") ; Keep this out of ~.
(savehist-mode t)                          ; Turn savehist-mode on.

(defun my-start-scripting-mode (file-extension hash-bang)
  ;; All scripting languages are programming languages
  (start-programing-mode)

  (local-set-key "\C-css" 'insert-script-seperator-line)
  (local-set-key "\C-csh" 'insert-script-section-header)
  (local-set-key "\C-csb" 'insert-script-big-header)

  ;; Build a startup template for this mode.
  ;; (my-start-autoinsert)
  ;; (tempo-define-template (concat file-extension "startup")
  ;;                        (list (concat hash-bang "\n\n")))
  ;; (push (cons (concat "\\." file-extension "$")
  ;;             (intern (concat "tempo-template-" file-extension "startup")))
  ;;       auto-insert-alist)

  ;; Make the script executable on save
  (add-hook 'after-save-hook
            'executable-make-buffer-file-executable-if-script-p
            nil t))

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)

(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

(setq gofmt-command "goimports")
(require 'go-mode-autoloads)
(add-hook 'go-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'gofmt-before-save)
            (require 'go-autocomplete)
            (require 'go-eldoc)
            (require 'go-errcheck)
            ;;(require 'go-flymake)
            ;;(require 'go-flycheck)
            (require 'go-guru)
            (require 'go-rename)
            (require 'golint)
            (go-eldoc-setup)
            (flyspell-prog-mode)
            (set-face-attribute 'eldoc-highlight-function-argument nil
                                :underline t :foreground "green"
                                :weight 'bold)
            )
          )

(require 'google-c-style)
(defun my-common-c-ish-startup ()
  (interactive)
  (start-programing-mode)

  (add-hook 'c-mode-common-hook 'google-set-c-style)
  (add-hook 'c-mode-common-hook 'google-make-newline-indent)

;; Load and start up filladapt
;  (require 'filladapt)
;  (c-setup-filladapt)
;  (filladapt-mode)

;  (when (project-root-p)
;    (local-set-key '[f4] 'erg-project-root-gdb)
;    (local-set-key '[f5] 'erg-project-root-compile)
;    (set-up-ffap-alist-for-project))
  )

(require 'org-install)
(setq org-startup-truncated nil)
(setq org-directory "~/Dropbox/TestOrg")
(setq org-mobile-directory "~/Dropbox/MobileOrg/")
(setq org-agenda-files (quote ("~/Dropbox/TestOrg/agenda.org")))
(setq org-mobile-inbox-for-pull "~/Dropbox/TestOrg/inbox.org")
(setq org-default-notes-file (expand-file-name "~/Dropbox/TestOrg/index.org"))
(add-hook 'org-mode-hook 'turn-off-filladapt-mode)

; (setq org-todo-keywords
;	'((type "TODO(t) "STARTED(s)" "WAITING(w)" "APP(a)" "|" "CANCELLED(c)" "DEFERRED(e)" "DONE(d)")
;	(sequence "PROJECT(p)" "|" "FINISHED(f)")
;	(sequence "INVOICE(i)" "SENT(n)" "|" "RCVD(r)")))

(add-hook 'c-mode-common-hook 'my-common-c-ish-startup)

(require 'protobuf-mode)
(setq auto-mode-alist
      (append '(("\\.proto\\'" . protobuf-mode))
              auto-mode-alist))

(require 'cmake-mode)
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
                ("\\.cmake\\'" . cmake-mode))
              auto-mode-alist))

(autoload 'php-mode "php-mode" "PHP mode." t)

(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

;; When programming, highlight long lines
(require 'highlight-beyond-fill-column)
(add-hook 'prog-mode-hook 'highlight-beyond-fill-column)
(custom-set-faces '(highlight-beyond-fill-column-face
                    ((t (:foreground "red" )))))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ns-alternate-modifier (quote none))
 '(ns-command-modifier (quote meta)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; Use file<pathname> instead of file<n> to uniquify buffer names.
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; server-mode: This starts up a server automatically, allowing emacsclient to
;; connect to a single Emacs instance.  If a server already exists, it is
;; killed.
(server-force-delete)
(server-start)

;; Replace echo area startup message
;;(setq yow-file "~/.emacs.d/yow_file_zippy_pinhead_quotes.txt.gz" )
;;(run-with-timer 1 nil #'yow)

;; Enable golint
(add-to-list 'load-path (concat (getenv "GOPATH")  "/src/github.com/golang/lint/misc/emacs"))
(require 'golint)

;; Enable markdown-mode
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Enable: yafolding
(require 'yafolding)
(add-hook 'prog-mode-hook
          (lambda () (yafolding-mode)))
;; The yafolding toggle keybindings are used common enough that I give them a
;; prominent keybdining.
(global-set-key (kbd "C-\\") 'yafolding-toggle-element)
(global-set-key (kbd "M-\\") 'yafolding-toggle-all)

;; Enable git-gutter+ when in prog-mode
(add-hook 'prog-mode-hook 'git-gutter+-mode)
(global-set-key (kbd "C-x g") 'git-gutter+-mode) ; Turn on/off in the current buffer
(global-set-key (kbd "C-x G") 'global-git-gutter+-mode) ; Turn on/off globally

(eval-after-load 'git-gutter+
  '(progn
     ;;; Jump between hunks
     (define-key git-gutter+-mode-map (kbd "C-x n") 'git-gutter+-next-hunk)
     (define-key git-gutter+-mode-map (kbd "C-x p") 'git-gutter+-previous-hunk)

     ;;; Act on hunks
     (define-key git-gutter+-mode-map (kbd "C-x v =") 'git-gutter+-show-hunk)
     (define-key git-gutter+-mode-map (kbd "C-x r") 'git-gutter+-revert-hunks)
     ;; Stage hunk at point.
     ;; If region is active, stage all hunk lines within the region.
     (define-key git-gutter+-mode-map (kbd "C-x t") 'git-gutter+-stage-hunks)
     (define-key git-gutter+-mode-map (kbd "C-x c") 'git-gutter+-commit)
     (define-key git-gutter+-mode-map (kbd "C-x C") 'git-gutter+-stage-and-commit)
     (define-key git-gutter+-mode-map (kbd "C-x C-y") 'git-gutter+-stage-and-commit-whole-buffer)
     (define-key git-gutter+-mode-map (kbd "C-x U") 'git-gutter+-unstage-whole-buffer)))
