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
	  necah yesod malkux))

(defun qb-letter-value (c)
  (pcase c
      (Alf 1)))

;;
;; some english
;;

(defconst *qb-alphabet* "abcdefghijklmnopqrstuvwxyz")
(defconst *qb-alephbeth*
  (string ?\x05D0 ?\x05D1 ?\x05D2 ?\x05D3 ?\x05D4 ?\x05D5 ?\x05D6 ?\x05D7 ?\x05D8 ?\x05D9
	  ;;?\x05DA    ;; final kaf
	  ?\x05DB
	  ?\x05DC
	  ;;?\x05DD    ;; final mem
	  ?\x05DE
	  ;;?\x05DF    ;; final nun
	  ?\x05E0 ?\x05E1 ?\x05E2
	  ;;?\x05E3    ;; final peh
	  ?\x05E4
	  ;;?\x05E5    ;; final cad
	  ?\x05E6
	  ?\x05E7 ?\x05E8 ?\x05E9 ?\x05EA
	  ))
(defconst *qb-finals*
  (string ?\x05DA ?\x05DD ?\x05DF ?\x05E3 ?\x05E5))

(defconst *qb-geresh* ?\x05F3)
(defconst *qb-gershaym* ?\x05F4)

;;(defconst *qb-alephbet* "abgdewzhtiklmnoypcqrsx")

(defun random-three (l)
  (loop repeat 3 collect (nth (random (length l)) l)))

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
