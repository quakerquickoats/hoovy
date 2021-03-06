(add-to-list 'load-path "~/.emacs.d/site-lisp")
;;(server-start)

;; (require 'org)
;; (org-babel-load-file "~/hoovy/emacs.org")

;;;
;;; Packages
;;; 

(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;;(add-to-list 'package-archives '("elpa" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/))"))

(defun packages ()
  (interactive)
  (package-list-packages nil)
  (hl-line-mode))

;;; 
;;; EXWM
;;; 

(when (require 'exwm nil :noerror)
  (require 'exwm-config)
  ;;(exwm-config-ido)
  ;;(exwm-enable-ido-workaround)
  (exwm-config-default)
  (setq exwm-workspace-number 4)

  (add-hook 'exwm-update-title-hook
	    (defun pnh-ff-title-hook ()
	      (when (string-match "Firefox" exwm-class-name)
		(exwm-workspace-rename-buffer exwm-title))))
  )

(defun kill_firefox ()
  "Kill all running firefox processes."
  (interactive)
  (call-process-shell-command "killall firefox"))

(global-set-key (kbd "M-p") 'kill_firefox)

;;;
;;; Treemacs
;;;

;; (add-to-list 'load-path "~/src/treemacs/src/elisp")
;; (require 'treemacs)

;;;
;;; Files
;;; 

(when (require 'persistent-scratch nil :noerror)
  (setq persistent-scratch-autosave-interval (* 60 10))
  (persistent-scratch-autosave-mode))

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)


(setq ibuffer-saved-filter-groups
      '(("default"
	 ("Emacs" (name . "^\\*"))
	 ("Dired" (mode . dired-mode)))))

(put 'dired-find-alternate-file 'disabled nil)

(setq-default bidi-display-reordering t)

;;;
;;; Utility functions
;;;

(defun hoovy-insert-date ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))

;;;
;;; ERC
;;;
(require 'erc)

(add-hook 'window-configuration-change-hook
            '(lambda ()
               (setq erc-fill-column (- (window-width) 2))))

(add-hook 'erc-mode-hook
            '(lambda ()
               (setq-local scroll-margin 1)))

;; shouldnt really be here, but in user config
(setq erc-autojoin-channels-alist
	  '(("freenode.net" "#emacs" "#lispgames" "#lisp" "##lisp" "#lispcafe"
         "#GNUstep" "#gamedev" "#prolog" "#xelf")
	    ("quakenet" "#rgrd")
	    ;;("efnet" "#buddhism")
	    ;;("undernet" "#buddhism"))
		;;erc-fill-column 100  ;; (- (window-width) 2)  ;; doesnt work here?
        ) 
      erc-kill-buffer-on-part t  ;; Kill buffers for channels after /part
      erc-kill-queries-on-quit t
      erc-log-channels-directory "~/log/"
      erc-save-buffer-on-part t
      erc-save-queries-on-quit t
      erc-log-write-after-insert t
      erc-log-write-after-send t
	  erc-hide-timestamps t
      erc-server-coding-system '(utf-8 . utf-8)
      erc-join-buffer 'bury
      ;;erc-lurker-hide-list '("JOIN" "PART" "QUIT")
	  erc-nick "oni-on-ion")

(require 'erc-hl-nicks nil :noerror)

;;(setq erc-fill-column (- (window-width) 2))
;;(setq erc-fill-column 100)  ;;same number, because window-width is not yet set.

(erc-log-mode) 


;;;
;;; Elfeed
;;; 
(when (require 'elfeed nil :noerror)
  (setq elfeed-feeds
	'("https://news.ycombinator.com/rss"
	  "http://planet.emacsen.org/atom.xml")))

;;(require 'emms-setup)
;;(emms-standard)
;;(emms-default-players)

;;;
;;; Programming
;;;
(setq-default c-basic-offset 4
              tab-width 4
              indent-tabs-mode nil)


(defun shell-cmd (cmd)
  "Returns the stdout output of a shell command or nil if the command returned
   an error"
  (car (ignore-errors (apply 'process-lines (split-string cmd)))))

;;----------------------------------------------------------------------------
;; OCaml/Reason setup
;;----------------------------------------------------------------------------

(add-to-list 'load-path
             "~/.opam/4.09.0/share/emacs/site-lisp/")

;;(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ;; Add the opam lisp dir to the emacs load path
;; (add-to-list 'load-path
;;              (replace-regexp-in-string
;;               "\n" "/usr/share/emacs/site-lisp"
;;               (shell-command-to-string "opam config var prefix")))

(let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var" "share")))))
  (when (and opam-share (file-directory-p opam-share))
    (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))))

;;(require 'sturgeon)

;;;;;;;; utop stuff ;;;;;;;
(when (require 'utop nil :noerror)
  (setq utop-command "opam config exec -- utop -emacs")
  (add-hook 'reason-mode-hook #'utop-minor-mode) ;; can be included in the hook above as well
  )

(let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var"
                                                     "share")))))
  (when (and opam-share (file-directory-p opam-share))
    ;; Register Merlin
    (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
    (autoload 'merlin-mode "merlin" nil t nil)
    ;; Automatically start it in OCaml buffers
    (add-hook 'tuareg-mode-hook 'merlin-mode t)
    (add-hook 'caml-mode-hook 'merlin-mode t)
    ;; Use opam switch to lookup ocamlmerlin binary
    (setq merlin-command 'opam)))

;; (let* ((refmt-bin (or (shell-cmd "refmt --where")
;;                       (shell-cmd "which refmt")))
;;        (merlin-bin (or (shell-cmd "ocamlmerlin --where")
;;                        (shell-cmd "which ocamlmerlin")))
;;        (merlin-base-dir (when merlin-bin
;;                           (replace-regexp-in-string "bin/ocamlmerlin$" "" merlin-bin))))
;;   ;; Add npm merlin.el to the emacs load path and tell emacs where to find ocamlmerlin
;;   (when merlin-bin
;;     (add-to-list 'load-path (concat merlin-base-dir "share/emacs/site-lisp/"))
;;     (setq merlin-command merlin-bin))

;;   (when refmt-bin
;;     (setq refmt-command refmt-bin)))

;; (when (require 'reason-mode nil :noerror)
;;   (require 'merlin)
;;   (add-hook 'reason-mode-hook (lambda ()
;;                                 (add-hook 'before-save-hook 'refmt-before-save)
;;                                 (merlin-mode)))

;;   (setq merlin-ac-setup t))

(require 'tuareg)
(setq tuareg-highlight-all-operators t)
(require 'merlin-eldoc)
(add-hook 'tuareg-mode-hook 'merlin-eldoc-setup)
(add-hook 'reason-mode-hook 'merlin-eldoc-setup)

;;;;;; iedit stuff ;;;;
;; (require 'merlin-iedit)
;; (defun evil-custom-merlin-iedit ()
;;   (interactive)
;;   (if iedit-mode (iedit-mode)
;;     (merlin-iedit-occurrences)))
;; (define-key merlin-mode-map (kbd "C-c C-e") 'evil-custom-merlin-iedit)


;;; -------------------------------------
;;; Prolog
;;; -------------------------------------
(when (require 'ediprolog nil :noerror)
  (global-set-key "\C-c\C-e" 'ediprolog-dwim)
  (add-to-list 'auto-mode-alist '("\\.pl?$" . prolog-mode)))

;;; --------------------------
;;; Erlang
;;; --------------------------
;; (add-to-list 'load-path "/usr/lib/erlang/tools-2.10.1/emacs")
;; (setq erlang-root-path "/usr/lib/erlang")
;; (add-to-list 'exec-path "/usr/lib/erlang/bin")

;; (add-to-list 'load-path "~/src/distel/elisp")
;; (require 'distel)
;; (distel-setup)

;; (defvar inferior-erlang-prompt-timeout t)
;; (setq inferior-erlang-machine-options '("-sname" "emacs"))
;; (setq erl-nodename-cache
;;       (make-symbol (concat "emacs@"
;; 			               (car (split-string
;; 				                 (shell-command-to-string "hostname"))))))

;; ;; (cl-flet ((erlpath (x) (concat x "/Program Files/erl9.0/")))
;; ;;   (add-to-list 'load-path (erlpath "/lib/tools-2.10/emacs"))
;; ;;   (setq erlang-root-dir (erlpath "/erts-9.0"))
;; ;;   (add-to-list 'exec-path (erlpath "/erts-9.0/bin"))
;; ;;   (setq erlang-man-root-dir (erlpath "/erts-9.0/man")))

;; (defun my-erlang-mode-hook ()
;;   (setq inferior-erlang-machine-options '("-sname" "emacs"))
;;   (imenu-add-to-menubar "imenu")
;;   (local-set-key [return] 'newline-and-indent))

;; ;; Some Erlang customizations
;; (add-hook 'erlang-mode-hook 'my-erlang-mode-hook)

;; (require 'erlang-start)

;; ;; (add-to-list 'auto-mode-alist '("\\.erl?$" . erlang-mode))
;; ;; (add-to-list 'auto-mode-alist '("\\.hrl?$" . erlang-mode))
;; ;;(erlang-indent-level 4)

;;; -----------------------------
;;; Common Lisp
;;; -----------------------------
(require 'cl)

(add-to-list 'auto-mode-alist '("\\.cl\\'" . lisp-mode))


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
(setq slime-lisp-implementations
      '((sbcl ("sbcl"))
	    (ecl ("/usr/local/bin/ecl"))
	    (nova ("~/nova/nova"))))

;(require 'slime-autoloads)
(load "~/quicklisp/slime-helper.el")
(setq slime-auto-connect 'ask)
(slime-setup '(slime-fancy slime-mrepl slime-banner slime-tramp
			   slime-xref-browser slime-highlight-edits
			   slime-sprof slime-asdf slime-company slime-indentation))
(setq common-lisp-hyperspec-root "file:///home/lyndon/Downloads/HyperSpec/")
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

;;; ------------------------------------
;;; Lisp
;;; ------------------------------------
;;(require 'rainbow-delimiters-mode)

(autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code." t)

(autoload 'snoopy-mode "snoopy"
    "Turn on unshifted mode for characters in the keyboard number row."
    t)

;; (macrolet ((fn (&body body)
;; 	       `(lambda (_) (print ,@body " ----"))))
;;   (mapc fn '(1 2 3 4)))

(font-lock-add-keywords
 'scheme-mode
 '(("\\<\\sw+:\\>" . 'font-lock-builtin-face)
   ("\\<#!\\sw+\\>" . 'font-lock-type-face))
 t)

(let ((modes-to-hook '(emacs-lisp-mode-hook
		       eval-expression-minibuffer-setup-hook
		       slime-repl-mode-hook
		       ielm-mode-hook
		       lisp-mode-hook
		       lisp-interaction-mode-hook
		       scheme-mode-hook)))
  (mapc (lambda (a)
	  (add-hook a 'snoopy-mode)
	  (add-hook a #'enable-paredit-mode)
      (add-hook a (lambda ()
                    (rainbow-delimiters-mode t))))
	modes-to-hook))

;;(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
;;(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
;;(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

;; (add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))
;; (add-hook 'lisp-mode-hook (lambda () (lispy-mode 1)))

;; (mapc (lambda (x)
;; 	(add-hook (quote x) (lambda () (lispy-mode))))
;;       '(emacs-lisp-mode-hook))

 	

(autoload 'gambit-inferior-mode "gambit" "Hook Gambit mode into cmuscheme.")
(autoload 'gambit-mode "gambit" "Hook Gambit mode into scheme.")
(add-hook 'inferior-scheme-mode-hook (function gambit-inferior-mode))
(add-hook 'scheme-mode-hook (function gambit-mode))
(setq scheme-program-name "gsi -:d-")


(when (require 'redshank-loader
               "~/.emacs.d/site-lisp/redshank/redshank-loader" :noerror)
  (eval-after-load "redshank-loader"
    `(redshank-setup '(lisp-mode-hook
		               slime-repl-mode-hook
		               ielm-mode-hook
		               emacs-lisp-mode-hook) t)))

;;; -------------------
;;; Hoovy
;;; -------------------
(load "~/hoovy/hoovy.el")

;;;
;;; Interface
;;; 

(setq browse-url-browser-function 'eww-browse-url)

(require 'ido)
(ido-mode t)

(setq mouse-autoselect-window nil)   ;; can't use with exwm
;;(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
;;(setq mouse-wheel-progressive-speed nil)

(windmove-default-keybindings)
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)

;;(global-hl-line-mode 1)
;; (and
;;   (require 'centered-cursor-mode)
;;   (global-centered-cursor-mode 1))

(menu-bar-mode nil)
(scroll-bar-mode nil)
(tool-bar-mode nil)
(setq visible-bell t)
(show-paren-mode t)

(setq prettify-symbols-alist
	  '(
		("lambda" . 955) ;;
		("->" . 8594)    ;;
		("=>" . 8658)    ;;
		;;("map" . 8614)    ;;
		("asdf" . "b")
		))
;;(global-prettify-symbols-mode 1)



;;; -------------------
;;; Julia
;;; -------------------

(when (require 'julia-mode nil :noerror)
  (add-to-list 'auto-mode-alist '("\\.jl?$" . julia-mode)))
