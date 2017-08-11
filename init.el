(defun insert-date ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))

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

;; (if (eq system-type 'windows-nt)
;;     (progn
;;       (setq explicit-shell-file-name "c:/cygwin/bin/bash.exe")
;;       (setq shell-file-name explicit-shell-file-name)
;;       (add-to-list 'exec-path "c:/cygwin/bin")))

;;
;; Erlang config
;;

;; (cl-flet ((erlpath (x) (concat x "/Program Files/erl9.0/")))
;;   (add-to-list 'load-path (erlpath "/lib/tools-2.10/emacs"))
;;   (setq erlang-root-dir (erlpath "/erts-9.0"))
;;   (add-to-list 'exec-path (erlpath "/erts-9.0/bin"))
;;   (setq erlang-man-root-dir (erlpath "/erts-9.0/man")))

;; (require 'erlang-start)

;; (add-to-list 'auto-mode-alist '("\\.erl?$" . erlang-mode))
;; (add-to-list 'auto-mode-alist '("\\.hrl?$" . erlang-mode))

;;
;; Lisp config
;;

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
(setf slime-scratch-file "~/Work/hoovy/scratch.lisp")

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
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

;; (add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))
;; (add-hook 'lisp-mode-hook (lambda () (lispy-mode 1)))


;; (mapc (lambda (x)
;; 	(add-hook (quote x) (lambda () (lispy-mode))))
;;       '(emacs-lisp-mode-hook))

(setq browse-url-browser-function 'eww-browse-url)


