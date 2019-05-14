(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

open Play
open Part
   
module Editor : Play.Game = struct
  type t = {
      info: Play.game_info;
      name: string;
      parts: int list;
      
      making: Part.t option;
      withPerf: performance;
    }
  let initial_state () = {
      info = {identifier = "edit";
              width = 1024;
              height = 640;
              background = Some (0 0 0 0);
              camera = (0 0 1)
             };
      name = "temp";
      parts = [];
      making = None;
      withPerf = Visual 
    }
  let step g _ = g
  let render g = ()
  let cleanup g = ()
end
