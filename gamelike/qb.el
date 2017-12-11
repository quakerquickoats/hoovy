;; -*- lexical-binding: t -*-
;;


;;
;; ivr
;;

(defconst *qb-otiyot*
  '(Alf Bet Gml Dal Heh Waw Zay Xet Tet Yod
    Kaf Lam Mem Nun Sam Iyn Peh Tza Qof Rsh Sin Tau))

(defconst *qb-sephirot*
  '(kexer hokama binae
	  hesed din xiperex-tifereth
	  necah hod yesod malkux))

;; keyboard transliteration. (set-language-input "Hebrew"), C-\
;;
;; qwertyuiop
;; asdfghjkl;'
;; zxcvbnm,./
;;
;; ׳קראטוןםפ
;; שדגכעיחלךף,
;; זסבהנמצתץ.
;;

;;
;; 22-letter english for transliteration. (see *qb-transliteration* below)
;;     not sure if i like "e" and "u" for Heh and Waw, or "h" and "w".
;;     we could just have caps/uncaps modes. cant for get Final Otiyot anyhow.
;;
;; abgdeuzx@iklmnsypcqr$t
;; אבגדהוזחטיכלמנסעפצקרשת
;;

(defconst *qb-key-alist*
  (let ((e "qwertyuiopasdfghjkl;'zxcvbnm,./")
	(h "/'קראטוןםפשדגכעיחלךף,זסבהנמצתץ."))
    (mapcar* #'cons e h)))

(defconst *qb-char-alist*
  (mapcar* #'cons *qb-transliteration* *qb-alephbeth*))

(defun qb-english-char-to-hebrew (c)
  (cdr (assoc c *qb-char-alist*)))
(defun qb-hebrew-char-to-english (c)
  (car (rassoc c *qb-char-alist*)))

(defun qb-transliterate-english (s)
  (assert (stringp s))
  (error "fail, do actual transliterating.")
  (concat (mapcar #'qb-english-char-to-hebrew s)))

(defun qb-transliterate-hebrew (s)
  (concat (mapcar #'qb-hebrew-char-to-english s)))

(defun qb-untransliterate-hebrew (s)
  (concat (mapcar #'qb-english-char-to-hebrew s)))

(defconst *qb-alphabet* "abcdefghijklmnopqrstuvwxyz")
(defconst *qb-alephbeth*
  (string ?\x05D0 ?\x05D1 ?\x05D2 ?\x05D3 ?\x05D4 ?\x05D5 ?\x05D6 ?\x05D7 ?\x05D8 ?\x05D9
	  ?\x05DB ?\x05DC ?\x05DE ?\x05E0 ?\x05E1 ?\x05E2 ?\x05E4 ?\x05E6
	  ?\x05E7 ?\x05E8 ?\x05E9 ?\x05EA
	  ?\x05DA    ;; final kaf
	  ?\x05DD    ;; final mem
	  ?\x05DF    ;; final nun
	  ?\x05E3    ;; final peh
	  ?\x05E5    ;; final cad
	  ))
(defconst *qb-transliteration* "ABGDHWZX@IKLMNS&PCQR$T")

(defconst *qb-geresh* ?\x05F3)
(defconst *qb-gershaym* ?\x05F4)

;;
;; gematria
;;

(defconst *qb-letter-values*
  (list
   1 2 3 4 5 6 7 8 9
   10 20 30 40 50 60 70 80 90
   100 200 300 400 600 700 800 900))

(defun qb-letter-value (c)
  (cdr (assoc c (mapcar* #'cons *qb-alephbeth* *qb-letter-values*))))

(defun qb-letter-values (s)
  (mapcar #'qb-letter-value s))

;;(defconst *qb-alephbet* "abgdewzhtiklmnoypcqrsx")

(defun qb-random-word (n &optional alphabet)
  (apply #'string
	 (qb-random-elements-of-list n (if alphabet alphabet *qb-alephbeth*))))

(defun qb-random-elements-of-list (n l)
  (loop repeat n collect (elt l (random (length l)))))

;;
;; base32
;;

(defvar *qb-base32-en* "0123456789abcdefghijklmnopqrstuvwxyz") ;; מקח
(defvar *qb-base32-he8 "0123456789אבגדהוזחטיכלמנסעפצקרשת")

;;
;;
;;

(defvar *es-aleph* [])

(defun es-aleph-image ()
  (create-image ))

;;
;; torah
;;

(defvar *qb-path* "/home/lyndon/.emacs.d/torah")

(defun qb-book-path (book)
  (make-directory *qb-path* t)
  (concat *qb-path* "/" book))

;;(defvar *qb-book* nil)

(defun qb--convert-xml (xml)
  (let ((contents (caddr (cadddr xml)) ))
    contents)  )

(defun qb-download-book (book)
  (url-copy-file (concat "https://tanach.us/Server.xml?" book "*" ;;"*&content=Consonants"
			 )
		 (qb-book-path book))
  (with-temp-buffer
    (insert-file-contents (qb-book-path book))
    (let ((xml (xml-to-esxml (buffer-string))))
      (qb--convert-xml xml)
      
      ;; (with-temp-file (qb-book-path book)
      ;; 	(prin1 xml))
      )))

(defun qb-read-book (book)
  (with-temp-buffer
    (insert-file-contents (qb-book-path book))
    (read (current-buffer))))

(defun qb-load-book (book)
  (if (file-exists-p (qb-book-path book))
      (qb-read-book book)
    (qb-download-book book)))

(defvar *qb-torah*
  `(:genesis ,(qb-download-book "Genesis")))

(defun qb-get-verse (book number)
  (with-temp-buffer
    (insert-file-contents (qb-book-path book))
    (let ((x (thing-at-point 'word t)))
      (while x
	(pcase x
	  ("xxxx" ignore)))
      
      (while (and x (not (eql (thing-at-point 'word t) "xxxx")))
	(forward-line)
	(setq x (thing-at-point 'word t)))
      x)))
