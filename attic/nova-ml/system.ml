(*
  Nova
  (c) 2019 Lyndon Tremblay
 *)

module type Context = sig
end

module type S = sig
  type t
     
  val init: int -> int -> string -> t
  val shutdown: t -> unit
  val getTime: unit -> float
  val pollEvents: t -> bool

  val beginFrame: t -> unit
  val endFrame: t -> unit
  val renderFrame: t -> Model.t -> unit
end

module Make(S: S) = struct
  let run title game =
    let sys = S.init 512 512 title in
    (* let module Game = (val game : Engine.Game) in *)
    let module E = Engine.Make(val game:Engine.Game) in
    let rec loop sys e =
      if S.pollEvents sys then begin
          S.beginFrame sys;
          S.renderFrame sys (E.getModel e);
          S.endFrame sys;
          loop sys (E.step e (S.getTime()))
        end
    in
    loop sys (E.create (S.getTime()));
    S.shutdown sys

  let runHeadless _title game =
    let module E = Engine.Make(val game:Engine.Game) in
    let _g = E.create 0. in
    ()
end

(*
  (*
  let init = foreign "NV_Init" (int @-> int @-> returning void)
  let shutdown = foreign "NV_Shutdown" (void @-> returning void)
  let update = foreign "NV_Update" (int @-> returning int)
   *)

  external init : int -> int -> unit = "NV_Init" [@@noalloc]
  external update : unit -> bool = "NV_Update" [@@noalloc]
  external endFrame : unit -> unit = "NV_EndFrame" [@@noalloc]
  external getTime : unit -> float = "NV_GetTime" [@@noalloc]
  external shutdown : unit -> unit = "NV_Shutdown" [@@noalloc]
 *)

               
