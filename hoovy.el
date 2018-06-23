;;; --------------------------------
;;; Hoovy
;;; --------------------------------

(defgroup hoovy nil
  "Hoovy Customization Group"
  :link '(custom-manual "(hoovy)Top"))

(defcustom hoovy-root "~/hoovy"
  "Root Path"
  :type 'directory
  :group 'hoovy)

(defcustom hoovy-apps
  '(("Krita" . "krita")
    ("Evince" . "evince")
    ("DOOM (Zandronum)" . "~/Downloads/zandronum")
    ("OpenToonz" . "opentoonz")
    ("Firefox" . "/opt/firefox/firefox"))
  "List of Applications"
  :type '(alist :key-type string :value-type file)
  :group 'hoovy)

(defun hoovy-spawn-app (name file)
  (let ((buf (concat "*" name "*")))
    (async-shell-command file buf buf)))

(require 'widget)
(eval-when-compile (require 'wid-edit))

(defun hoovy-all-apps ()
  "add earmuffs to hoovy-apps"
  (mapcar (lambda (x) `(,(concat "*" (car x) "*") . ,(cdr x)))
	   hoovy-apps))

(defun hoovy-welcome ()
  "Hoovy Welcome Page"
  (interactive)
  (switch-to-buffer "Hoovy")
  (kill-all-local-variables)
  ;;(make-local-variable 'asdfasdf)
  (let ((inhibit-read-only t))
    (erase-buffer))
  (remove-overlays)
  (widget-insert "Welcome to Hoovy Studio\n\n")
  (dolist (a (hoovy-all-apps))
    (widget-create 'push-button
		   :notify (lambda (&rest ignore)
			     (async-shell-command (cdr a)
						  (car a) (car a)))
		   (car a)))
  (use-local-map widget-keymap)
  (widget-setup))

;;; --------------------------------
;;; Org Mode
;;; --------------------------------
(require 'org)
(defun hoovy-www () (concat hoovy-root "/www/"))
(setq org-default-notes-file (concat hoovy-root "/notes.org"))

(define-key global-map (kbd "C-c c") 'org-capture)

;; (defun hv-make-notes (&optional name)
;;   `(,(concat name "-notes")
;;    :base-directory ,(concat hv-root "/" name "/org")
;;    :base-extension "org"
;;    :publishing-function org-publish-org-to-html
;;    :publishing-directory ,(concat hv-www "/dev/" name)
;;    :auto-sitemap t
;;    :sitemap-title "/Site Map/"
;;    :sitemap-alphabetically nil
;;    :recursive t
;;    :style-include-default t
;;    :headline-levels 4
;;    :auto-preamble t))

;; (defun hv-make-static (&optional name)
;;   `(,(concat name "-static")
;;     :base-directory ,(concat hv-root "/" name "/org")
;;     :base-extension "css\\|js\\|png\\|gif\\|pdf\\|mp3\\|ogg\\|svg"
;;     :publishing-function org-publish-attachment
;;     :publishing-directory ,(concat hv-www "/dev/" name)
;;     :recursive t))

;; (setq org-capture-templates
;;       '(("t" "Todo" entry (file+headline "" "Tasks")
;;          "* TODO %?\n  %i\n  %a")
;;         ("j" "Journal" entry (file+datetree "")
;;          "* %?\nEntered on %U\n  %i\n  %a")))

(setq org-publish-project-alist
      `(("hoovy"
		 :components ("hoovy-org" "hoovy-art" "hoovy-code"))
		("hoovy-org"
		 :auto-sitemap t
		 :base-directory ,hoovy-root
		 :base-extension "org"
		 :publishing-directory ,(hoovy-www)
		 :publishing-function org-html-publish-to-html
		 :recursive t
		 :html-head "<link rel='stylesheet' href='style.css' type='text/css'/>"
		 :html-head-extra ""
		 :html-preamble t
		 :components ())
		("hoovy-art"
		 :base-directory ,(concat hoovy-root "/images/")
		 :base-extension "jpg\\|gif\\|png\\|svg"
		 :publishing-directory ,(hoovy-www)
		 :publishing-function org-publish-attachment)
		("hoovy-code"
		 :base-directory ,(concat hoovy-root "/apps/")
		 :base-extension "css\\|el\\|js"
		 :publishing-directory ,(hoovy-www)
		 :publishing-function org-publish-attachment)))

(org-display-inline-images t t)
(setq org-edit-src-content-indentation 0
      org-src-tab-acts-natively t
      org-src-fontify-natively t
      org-confirm-babel-evaluate nil
      org-support-shift-select 'always)

(org-babel-do-load-languages 'org-babel-load-languages
    '((emacs-lisp . t)
      (shell . t)
	  (ocaml . t)
	  (lisp . t)))
