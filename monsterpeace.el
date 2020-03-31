;;
;; game
;;

(cl-defstruct mp:status
  level hp xp
  str vit agi dex int luk)

(cl-defstruct mp:actor name (status :type mp:status))

