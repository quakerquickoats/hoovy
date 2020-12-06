;;
;; Nova
;; (c) 2020 Lyndon Tremblay
;;

(in-package :nova)

(defclass MapRoom ()
  (name
   size))


(defparameter ItemTypes
  '(Food
    Potion
    Scroll
    Ammo
    Key
    Material   ;; building and crafting
    Gear ;; Weapon, Armor
    
    ))

;; 'Orb' item type, Projectile.
;; used to seal an element or spell, to throw and break or to carry powers.


(defparameter ActorStatus
  '(HP SP XP JP ;; Health, Spirit/Magic, Experience, Job
    Level   ;; can calculate XP req'd from here
    Gold
    Items[]
    ))
