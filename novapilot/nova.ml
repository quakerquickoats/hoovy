(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

(*open Gg
  open Ctypes
  open Foreign
 *)

open GLFW

module Nova = struct
  (*
  let init = foreign "NV_Init" (int @-> int @-> returning void)
  let shutdown = foreign "NV_Shutdown" (void @-> returning void)
  let update = foreign "NV_Update" (int @-> returning int)
   *)

  let init w h =
    GLFW.init ();
    windowHint ~hint:WindowHint.ContextVersionMajor ~value:3;
    windowHint ~hint:WindowHint.ContextVersionMinor ~value:3;
    windowHint ~hint:WindowHint.OpenGLProfile ~value:CoreProfile;
    windowHint ~hint:WindowHint.RefreshRate ~value:(Some 60);
    windowHint ~hint:WindowHint.DepthBits ~value:None;

    let w = GLFW.createWindow 320 240 "Novapilot" () in
    GLFW.makeContextCurrent ~window:(Some w);
    print_string "OK.";

    GLFW.setInputMode ~window:w ~mode:StickyKeys ~value:true;
    w

  let update w =
    GLFW.pollEvents ();
    if (GLFW.getKey ~window:w ~key:GLFW.Escape) ||
         (GLFW.windowShouldClose ~window:w) then
      false
    else
      true

  let endFrame w =
    GLFW.swapBuffers ~window:w;;
    
  let shutdown w =
    GLFW.destroyWindow w;
    GLFW.terminate ();
  
  (* any two points are colinear *)
  (* any three points are coplanar *)
  type point = float
  type line = point * point
  type plane = line * point   (* shouldnt be on same line, noncolinear *)

  (* the intersection of two lines is a point  *)
  (* the intersection of two planes is a line *)

  type segment = point * point (* part of a line *)
  type ray = point * point (* point and direction *)
  (* opposite ray shares endpoint and inverted direction *)
  (* segments with equal lengths are considered Congruent *)
  (* B is between A and C if they are colinear and AB + BC = AC. *)
  (* midpoint of a segment is the point that divides into
     two congruent segments *)
  (* a segment bisector is any line, ray, plane or segment that
     intersects a segment at midpoint. *)
  (* a perpendicular bisector intersects the segment and is
     perpendicular to it. *)

  type angle = point * point * point   (* *)

  (* and ANGLE is a figure formed by two rays with a common endpoint. *)
  (* the common endpoint is the VERTEX of the Angle *)
  (* the Rays are the sides of the angle *)
  (* angles are formed when lines, rays, or segments intersect *)
  (* an Angle divides the Plane into two regions, Interior and Exterior. *)
  (* if two Points from each side of the Angle are connected with a
     Segment, the Segment passes through the interior of the Angle. *)
end
                  
