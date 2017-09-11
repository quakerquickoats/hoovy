(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(defun insert-date ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))

(setq mouse-autoselect-window t)

(require 'ido)
(ido-mode t)

(setq ibuffer-saved-filter-groups
      '(("default"
	 ("Emacs" (name . "^\\*"))
	 ("Dired" (mode . dired-mode)))))

(setq visible-bell t)
;;(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
;;(setq mouse-wheel-progressive-speed nil)

(package-initialize)
;(add-to-list 'package-archives '("elpa" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/))"))

(require 'elfeed)
(setq elfeed-feeds
      '("https://news.ycombinator.com/rss"
        "http://planet.emacsen.org/atom.xml"))

(setq browse-url-browser-function 'eww-browse-url)

;; (if (eq system-type 'windows-nt)
;;     (progn
;;       (setq explicit-shell-file-name "c:/cygwin/bin/bash.exe")
;;       (setq shell-file-name explicit-shell-file-name)
;;       (add-to-list 'exec-path "c:/cygwin/bin")))

(autoload 'snoopy-mode "snoopy"
  "Turn on unshifted mode for characters in the keyboard number row." t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Erlang config
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "/usr/lib/erlang/tools-2.10.1/emacs")
(setq erlang-root-path "/usr/lib/erlang")
(add-to-list 'exec-path "/usr/lib/erlang/bin")

(add-to-list 'load-path "~/Downloads/distel/elisp")
(require 'distel)
(distel-setup)

(defvar inferior-erlang-prompt-timeout t)
(setq inferior-erlang-machine-options '("-sname" "emacs"))
(setq erl-nodename-cache
      (make-symbol (concat "emacs@"
			   (car (split-string
				 (shell-command-to-string "hostname"))))))

;; (cl-flet ((erlpath (x) (concat x "/Program Files/erl9.0/")))
;;   (add-to-list 'load-path (erlpath "/lib/tools-2.10/emacs"))
;;   (setq erlang-root-dir (erlpath "/erts-9.0"))
;;   (add-to-list 'exec-path (erlpath "/erts-9.0/bin"))
;;   (setq erlang-man-root-dir (erlpath "/erts-9.0/man")))

(defun my-erlang-mode-hook ()
        ;; when starting an Erlang shell in Emacs, default in the node name
        (setq inferior-erlang-machine-options '("-sname" "emacs"))
        ;; add Erlang functions to an imenu menu
        (imenu-add-to-menubar "imenu")
        ;; customize keys
        (local-set-key [return] 'newline-and-indent))

;; Some Erlang customizations
(add-hook 'erlang-mode-hook 'my-erlang-mode-hook)

(require 'erlang-start)

;; (add-to-list 'auto-mode-alist '("\\.erl?$" . erlang-mode))
;; (add-to-list 'auto-mode-alist '("\\.hrl?$" . erlang-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Lisp config
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'cl)

(defun slime-style-init-command (port-filename _coding-system extra-args)
  "Return a string to initialize Lisp."
  (let ((loader (if (file-name-absolute-p slime-backend)
                    slime-backend
                  (concat slime-path slime-backend))))
    ;; Return a single form to avoid problems with buffered input.
    (format "%S\n\n"
            `(progn
               (load ,(slime-to-lisp-filename (expand-file-name loader))
                     :verbose t)
               (funcall (read-from-string "swank-loader:init"))
               (funcall (read-from-string "swank:start-server")
                        ,(slime-to-lisp-filename port-filename)
			,@extra-args)))))

(defun slime-style (&optional style)
  (interactive
   (list (intern-soft (read-from-minibuffer "Style: " "nil"))))
  (lexical-let ((style style))
    (slime-start
     :init (lambda (x y)
	     (slime-style-init-command
	      x y `(:style ,style :dont-close t))))))

(setq inferior-lisp-program "sbcl")

;; (setq slime-lisp-implementations
;;       '((sbcl-w32 ("C:\\msys32\\mingw32\\bin\\sbcl.exe"
;; 		   "--core"
;; 		   "C:\\msys32\\mingw32\\lib\\sbcl\\sbcl.core"))
;; 	(sbcl-old ("C:\\Program Files\\Steel Bank Common Lisp\\1.3.12\\sbcl.exe"
;; 	       "--core"
;; 	       "C:\\Program Files\\Steel Bank Common Lisp\\1.3.12\\sbcl.core"))
;; 	(ecl ("c:\\msys32\\mingw32\\ecl.exe"))
;; 	(nova ("c:\\Users\\Quaker\\nova\\nova.exe"))))

;(add-to-list 'load-path "/users/quaker/quicklisp/dists/quicklisp/software/slime-v2.18")
;(require 'slime-autoloads)
(load "~/quicklisp/slime-helper.el")
(setq slime-auto-connect 'ask)
(slime-setup '(slime-fancy slime-mrepl slime-banner slime-tramp
			   slime-xref-browser slime-highlight-edits
			   slime-sprof slime-asdf slime-company))
(setq common-lisp-hyperspec-root "file:///Users/Quaker/Downloads/HyperSpec/")
(global-set-key "\C-cs" 'slime-selector)
(setf slime-scratch-file "~/hoovy/scratch.lisp")

;; (defun my-slime-setup ()
;;   (require 'slime)
;;   (slime-setup))

;; (defvar my--slime-setup-done nil)
;; (defun my-slime-setup-once ()
;;   (unless my--slime-setup-done
;;     (my-slime-setup)
;;     (setq my--slime-setup-done t)))
;; (defadvice lisp-mode (before my-slime-setup-once activate)
;;   (my-slime-setup-once))


(autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code." t)

(autoload 'snoopy-mode "snoopy"
    "Turn on unshifted mode for characters in the keyboard number row."
    t)

;; (macrolet ((fn (&body body)
;; 	       `(lambda (_) (print ,@body " ----"))))
;;   (mapc fn '(1 2 3 4)))

(let ((modes-to-hook '(emacs-lisp-mode-hook
		       eval-expression-minibuffer-setup-hook
		       ielm-mode-hook
		       lisp-mode-hook
		       lisp-interaction-mode-hook
		       scheme-mode-hook)))
  (mapc (lambda (a)
	  (add-hook a 'snoopy-mode)
	  (add-hook a #'enable-paredit-mode))
	modes-to-hook))

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

;; (add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))
;; (add-hook 'lisp-mode-hook (lambda () (lispy-mode 1)))

;; (mapc (lambda (x)
;; 	(add-hook (quote x) (lambda () (lispy-mode))))
;;       '(emacs-lisp-mode-hook))


(require 'redshank-loader "~/.emacs.d/site-lisp/redshank/redshank-loader")
(eval-after-load "redshank-loader"
  `(redshank-setup '(lisp-mode-hook
		     slime-repl-mode-hook
		     ielm-mode-hook
		     emacs-lisp-mode-hook) t))