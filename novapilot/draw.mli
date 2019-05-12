(* type resource =
 *   | Image of
 *       {id:int;
 *        width:int;
 *        height:int}
 *   | Framebuffer of
 *       {id:int} *)

val initFrame : int -> int -> unit

val createShader : unit -> int
(* val createLayer : int -> int -> Cairo.Surface.t -> resource
 * val updateLayer : resource -> Cairo.Surface.t -> unit *)
val createLayer : int -> int -> Cairo.Surface.t -> int
val updateLayer : int -> int -> int -> Cairo.Surface.t -> unit
    
      
                                              
