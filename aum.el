(defun insert-date ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))

(require 'ido)
(ido-mode t)

(setq visible-bell t)

(package-initialize)
;(add-to-list 'package-archives '("elpa" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/))"))

;; (if (eq system-type 'windows-nt)
;;     (progn
;;       (setq explicit-shell-file-name "c:/cygwin/bin/bash.exe")
;;       (setq shell-file-name explicit-shell-file-name)
;;       (add-to-list 'exec-path "c:/cygwin/bin")))

;;
;; Erlang config
;;

;; (flet ((erlpath (x) (concatenate 'string x "/Program Files/erl8.2/")))
;;   (add-to-list 'load-path (erlpath "/lib/tools-2.9/emacs"))
;;   (setq erlang-root-dir (erlpath "/erts-8.2"))
;;   (add-to-list 'exec-path (erlpath "/erts-8.2/bin"))
;;   (setq erlang-man-root-dir (erlpath "/erts-8.2/man")))

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

(setq inferior-lisp-program "nova")
(setq slime-lisp-implementations
      '((ecl ("c:\\msys32\\mingw32\\ecl.exe"))
	(nova ("c:\\Users\\Quaker\\nova\\nova.exe"))
	(sbcl ("C:\\Program Files\\Steel Bank Common Lisp\\1.3.9\\sbcl.exe"
	    "--core" "C:\\Program Files\\Steel Bank Common Lisp\\1.3.9\\sbcl.core"))))

;(add-to-list 'load-path "/users/quaker/quicklisp/dists/quicklisp/software/slime-v2.18")
;(require 'slime-autoloads)
(load "/users/quaker/quicklisp/slime-helper.el")
(setq slime-auto-connect 'ask)

(setq common-lisp-hyperspec-root "file:///Users/Quaker/Downloads/HyperSpec/")
(setq browse-url-browser-function 'eww-browse-url)

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


