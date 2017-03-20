;; Game-SDL
;;
;; (c) 2017 Lyndon Tremblay
;;

(asdf:load-system :cffi)

(defpackage :game-sdl
  (:use :cl :cffi))

(in-package :game-sdl)

(define-foreign-library libsdl
    (t (:default "sdl2")))

(use-foreign-library libsdl)

;;;;;;;;

;; SDL.h

(defcenum sdl-init
  (:timer    #x00000001)
  (:audio    #x00000010)
  (:video    #x00000020)
  (:joystick #x00000200)
  (:haptic   #x00001000)
  (:gamectrl #x00002000)
  (:events   #x00004000))

(defcfun "SDL_Init" :int (flags :uin32))
(defcfun "SDL_InitSubSystem" :int (flags :uint32))
(defcfun "SDL_QuitSubSystem" :void (flags :uint32))
(defcfun "SDL_WasInit" :uint32 (flags :uint32))
(defcfun "SDL_Quit" :void)

;; SDL_error.h

(defcfun "SDL_GetError" :string)
(defcfun "SDL_ClearError" :void)

;; SDL_video

(defctype sdl-window :pointer)

(defcenum sdl-windowflags
  (:fullscreen     #x00000001)
  (:opengl         #x00000002)
  (:shown          #x00000004)
  (:hidden         #x00000008)
  (:borderless     #x00000010)
  (:resizable      #x00000020)
  (:minimized      #x00000040)
  (:maximized      #x00000080)
  (:input-grabbed  #x00000100)
  (:input-focus    #x00000200)
  (:mouse-focus    #x00000400)
  ;(:fullscreen-dsk #x00000800)
  (:foreign        #x00000800)
  (:allow-highdpi  #x00002000)
  (:mouse-capture  #x00004000)
  (:always-on-top  #x00008000)
  (:skip-taskbar   #x00010000)
  (:utility        #x00020000)
  (:tooltip        #x00040000)
  (:popup-menu     #x00080000))

(defcenum sdl-windowevent
  (:none))
