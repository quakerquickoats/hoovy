;;
;;


;;
;; ivr
;;

(defconst *qb-otiyot*
  '(Alf Bet Gml Dal Heh Waw Zay Xet Tet Yod
    Kaf Lam Mem Nun Sam Iyn Peh Tza Qof Rsh Sin Tau))

(defconst *qb-sephirot*
  '(keter hokma bina
    hesed ))

;;
;; some english
;;

(defconst *qb-alphabet* "abcdefghijklmnopqrstuvwxyz")
(defconst *qb-alephbet* "abgdewzxtiklmnoypcqrsx")

(defun random-three ()
  (loop repeat 3 collect (nth (random (length alphabet)) alphabet)))

;;
;;
;;

(defvar *es-aleph* [])

(defun es-aleph-image ()
  (create-image ))
