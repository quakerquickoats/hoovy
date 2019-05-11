(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

open Nova
open System_glfw

open Foreign
open Ctypes

module Nanovg = struct
  let createGL3 = foreign "nvgCreateGL3" (int @-> returning (ptr int))
end

let () =
  let w, h = 320, 240 in
  let s = System.init w h "Novapilot" in

  (*
  let i = Cairo.Image.create Cairo.Image.ARGB32 ~w ~h in
  let c = Cairo.create i in
  Cairo.scale c 1. 1.; *)
  
  (*  let fbo = Bigarray.(Array1.create Int32 c_layout 1) in
  Gl.gen_framebuffers 1 fbo;*)
  (* let tex = Nova.createTexture w h i in
  let (gID,_) = Nova.createModel () in *)
  (* let fb = Nova.createFramebuffer w h in *)

  let vg = Nanovg.createGL3 0 in
  print_int (!@ vg);
  print_newline ();

  while System.update s do
    Nova.prepareScene w h;
    (* Nova.bindTexture tex; *)

    (* Nova.withFramebuffer fb (fun () ->
     *     Cairo.Surface.flush i;
     *     Cairo.Surface.finish i;
     *   ); *)

    (* Nova.drawModel gID; *)
    
    System.endFrame s;
  done;

  System.shutdown s
    
