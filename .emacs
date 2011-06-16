(defvar my-load-path (expand-file-name "~/.emacs.d/lisp"))
(add-to-list 'load-path my-load-path)

(setq byte-compile-warnings nil)

(setq-default line-number-mode t)
(setq-default column-number-mode t)
(setq-default tab-width 4)

;; All trailing whitespace needs to be highlighted so it can die.
(setq-default show-trailing-whitespace t)
(setq-default indent-tabs-mode nil)
(setq indent-tabs-mode nil)
(setq c-basic-offset 2)
(setq c-basic-indent 2)

(display-time)

;; Draw tabs with the same color as trailing whitespace
(add-hook 'font-lock-mode-hook
  (lambda ()
    (font-lock-add-keywords
      nil
      '(("\t" 0 'trailing-whitespace prepend)))))

(prefer-coding-system 'utf-8)

(setq auto-mode-alist
      (append '(("\\.[Cc][Xx][Xx]$" . c++-mode)
                ("\\.[Cc][Pp][Pp]$" . c++-mode)
                ("\\.[Hh][Xx][Xx]$" . c++-mode)
                ("\\.[Tt][Cc][Cc]$" . c++-mode)
                ("\\.h$" . c++-mode)
                ("\\.mak$" . makefile-mode)
                ("\\.conf$" . conf-mode)
                ("\\.lua$" . lua-mode)
                ("Doxyfile.tmpl$" . makefile-mode)
                ("Doxyfile$" . makefile-mode)
                ("\\.php$" . php-mode)
                ("\\.rb$" . ruby-mode)
                ("\\.y$" . bison-mode)
                ("\\.yy$" . bison-mode)
                ("\\.l$" . flex-mode)
                ("\\.ll$" . flex-mode)
                ) auto-mode-alist))

(setq interpreter-mode-alist
      (append '(("ruby" . ruby-mode))
              interpreter-mode-alist))

(setq user-full-name "Firstname Lastname"
      user-mail-address "user@example.com"

      enable-local-variables :safe
      inhibit-startup-message t
      default-major-mode 'text-mode
      require-final-newline t
      default-fill-column 77
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

  ;; Highlight matching parenthesis (and other bracket likes)
  (show-paren-mode t))


(defun my-start-scripting-mode (file-extension hash-bang)
  ;; All scripting languages are programming languages
  (start-programing-mode)

  (local-set-key "\C-css" 'insert-script-seperator-line)
  (local-set-key "\C-csh" 'insert-script-section-header)
  (local-set-key "\C-csb" 'insert-script-big-header)

  ;; Build a startup template for this mode.
  (my-start-autoinsert)
  (tempo-define-template (concat file-extension "startup")
                         (list (concat hash-bang "\n\n")))
  (push (cons (concat "\\." file-extension "$")
              (intern (concat "tempo-template-" file-extension "startup")))
        auto-insert-alist)

   Make the script executable on save
  (add-hook 'after-save-hook
            'executable-make-buffer-file-executable-if-script-p
            nil t))


(defun my-common-c-ish-startup ()
  (interactive)
  (start-programing-mode)

  (require 'google-c-style)
  (google-set-c-style)

  (auto-revert-mode t)

  ;; Load and start up filladapt
;  (require 'filladapt)
;  (c-setup-filladapt)
;  (filladapt-mode)

;  (when (project-root-p)
;    (local-set-key '[f4] 'erg-project-root-gdb)
;    (local-set-key '[f5] 'erg-project-root-compile)
;    (set-up-ffap-alist-for-project))
  )

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
