;; Export org files
;;
;; Copyright (C) 2010 Lyndon Tremblay <humasect@gmail.com>
;; Created: Tue Sep 21 03:51:43 MDT 2010
;; Updated August 2016.
;;

;(require 'org-publish)

(defconst hv-root "/hv/")
(defconst hv-www "/hv/htdocs/")

(defun hv-make-notes (&optional name)
  `(,(concat name "-notes")
   :base-directory ,(concat hv-root "/" name "/org")
   :base-extension "org"
   :publishing-function org-publish-org-to-html
   :publishing-directory ,(concat hv-www "/dev/" name)
   :auto-sitemap t
   :sitemap-title "/Site Map/"
   :sitemap-alphabetically nil
   :recursive t
   :style-include-default t
   :headline-levels 4
   :auto-preamble t))

(defun hv-make-static (&optional name)
  `(,(concat name "-static")
    :base-directory ,(concat hv-root "/" name "/org")
    :base-extension "css\\|js\\|png\\|gif\\|pdf\\|mp3\\|ogg\\|svg"
    :publishing-function org-publish-attachment
    :publishing-directory ,(concat hv-www "/dev/" name)
    :recursive t))

(defun hv-publish ()
  (interactive)
  (let ((org-publish-project-alist
         `(
           ,(hv-make-notes)
           ,(hv-make-static)
           ("hv" :components ("-notes" "-static"))

           ;;,(erl-make-notes "zen")
           ;;,(erl-make-static "zen")
           ;;("zen" :components ("zen-notes" "zen-static"))

           ;;,(erl-make-notes "vre")
           ;;,(erl-make-static "vre")
           ;;("vre" :components ("vre-notes" "vre-static"))

           ;;,(erl-make-notes "val")
           ;;,(erl-make-static "val")
           ;;("val" :components ("val-notes" "val-static"))

           )))

    ;;(org-publish-project "erl")
    ;;(org-publish-project "zen")
    ;;(org-publish-project "vre")
    (org-publish-project "hv")))


(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "")
         "* %?\nEntered on %U\n  %i\n  %a")))

(setq org-default-notes-file (concat hv-root "/org/notes.org"))
(define-key global-map (kbd "C-c c") 'org-capture)
;(add-to-list 'org-export-html-inline-image-extensions "svg")


;(global-set-key (kbd "s-o") 'erl-publish)

