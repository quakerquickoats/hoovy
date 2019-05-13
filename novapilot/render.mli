   
(* type resource =
 *   | Image of
 *       {id:int;
 *        width:int;
 *        height:int}
 *   | Framebuffer of
 *       {id:int} *)

type image
val getSurface: image -> Cairo.Surface.t  (* temp *)

val createShaders: unit -> int

val createCanvas: int -> int -> image
val uploadCanvas: image -> unit
val prepareCanvas: image -> unit
val renderCanvas: image -> unit
                             
    
      
                                              
