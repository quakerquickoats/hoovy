;;;;; C  -*- lexical-binding: t; -*-

;;;;;;;;;;;;;
;;;;;
;;;;; general
;;;;;
;;;;;;;;;;;;;

(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "/usr/local/opt/llvm/bin")

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default c-basic-offset 4)
(setq-default c-indent-level 4)
(setq-default c-default-style "linux")

(windmove-default-keybindings)
(ido-mode)

;;;;; hebrew (macOS)

(set-fontset-font t 'hebrew "New Peninim MT 24")

;;======================
;;
;; BrightScript
;;
;;======================

(require 'brightscript-mode)
(add-to-list 'auto-mode-alist '("\\.brs\\'" . brightscript-mode))

;;;;;;;;;;;;
;;;;;
;;;;; prolog
;;;;;
;;;;;;;;;;;;

(require 'sweeprolog)

;;(setq sweeprolog-swipl-path "/path/to/swipl")
;; (let ((swipl-path "/Applications/SWI-Prolog.app/Contents/MacOS"))
;;   ;;(add-to-list 'exec-path swipl-path)
;;   (setq sweeprolog-swipl-path swipl-path))

(add-to-list 'auto-mode-alist '("\\.pl\\'" . sweeprolog-mode))
(add-to-list 'auto-mode-alist '("\\.P\\'" . sweeprolog-mode))


;;;;;;;;;;;
;;;;;
;;;;; ocaml
;;;;;
;;;;;;;;;;;

(setq tuareg-highlight-all-operators t)
(setq tuareg-prettify-symbols-full t)
(add-hook 'tuareg-mode-hook
            (lambda()
              (when (functionp 'prettify-symbols-mode)
                (prettify-symbols-mode))))

(face-spec-set
   'tuareg-font-lock-constructor-face
   '((((class color) (background light)) (:foreground "SaddleBrown"))
     (((class color) (background dark)) (:foreground "burlywood1"))))


;;(load "/Users/lyndon/.opam/default/share/emacs/site-lisp/tuareg-site-file")
(let ((opam-share (ignore-errors (car (process-lines "opam" "var" "share")))))
  (when (and opam-share (file-directory-p opam-share))
    ;; Register Merlin
    (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
    (autoload 'merlin-mode "merlin" nil t nil)
    ;; Automatically start it in OCaml buffers
    (add-hook 'tuareg-mode-hook 'merlin-mode t)
    (add-hook 'caml-mode-hook 'merlin-mode t)
    ;; Use opam switch to lookup ocamlmerlin binary
    (setq merlin-command 'opam)))

;;;;;;;;;;
;;;;;
;;;;; lisp
;;;;;
;;;;;;;;;;

(setq inferior-lisp-program "/usr/local/bin/sbcl")
;; https://github.com/informatimago/emacs/blob/master/slime-rpc.el
(require 'slime)

(setf slime-enable-evaluate-in-emacs t)

(defun eval-in-cl (cl-expression-string process-result-values)
  (slime-eval-async
   `(swank:eval-and-grab-output ,(format "(cl:multiple-value-list %s)"
                                        cl-expression-string))
   (lexical-let  ((here (current-buffer)) ; shall we use a marker?
                  (process-result-values process-result-values))
     (lambda (result-values)
       (set-buffer here)
       (funcall process-result-values result-values))))
  nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf"
    "#eeeeec"])
 '(c-basic-offset 4)
 '(custom-enabled-themes '(manoj-dark))
 '(fringe-mode 0 nil (fringe))
 '(package-archives
   '(("melpa" . "https://melpa.org/packages/")
     ("stable melpa" . "https://stable.melpa.org/packages/")
     ("gnu" . "https://elpa.gnu.org/packages/")
     ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
 '(package-selected-packages
   '(brightscript-mode haskell-mode markdown-mode merlin nethack paredit
                       slime smalltalk-mode snoopy sweeprolog treemacs
                       treemacs-all-the-icons treemacs-magit
                       treesit-auto))
 '(tool-bar-mode nil)
 '(tuareg-highlight-all-operators t t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#222" :foreground "WhiteSmoke" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 120 :width normal :foundry "nil" :family "Menlo"))))
 '(font-lock-comment-delimiter-face ((t (:foreground "#999"))))
 '(font-lock-comment-face ((t (:foreground "#999" :slant oblique))))
 '(font-lock-function-name-face ((t (:foreground "#aaaaff" :weight bold))))
 '(font-lock-keyword-face ((t (:foreground "green"))))
 '(font-lock-preprocessor-face ((t (:foreground "yellow" :slant italic))))
 '(font-lock-string-face ((t (:foreground "cyan1"))))
 '(font-lock-type-face ((t (:foreground "SteelBlue1"))))
 '(font-lock-variable-name-face ((t (:foreground "#aaf"))))
 '(sweeprolog-head-built-in ((t (:background "Brown" :weight bold))))
 '(tuareg-font-lock-governing-face ((t (:foreground "green"))))
 '(tuareg-font-lock-operator-face ((t (:foreground "yellow")))))
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
