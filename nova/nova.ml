open Gg

open Geom
   
   
type input = {
    up_arrow: bool; down_arrow: bool; left_arrow: bool; right_arrow: bool;
    char_states: char * bool;
    move_vector: v2;

    left_button: bool; middle_button: bool; right_button: bool;

(*    type cursor = {
        c: V2;
        last: V2;
        delta: V2;
      } *)
    cursor: v2; last_cursor: v2; delta: v2;
    screen_cursor: v2; last_screen_cursor: v2; screen_delta: v2;
  }

let no_input = {
    up_arrow = false; down_arrow = false; left_arrow = false; right_arrow = false;
    char_states = ('a',false);
    move_vector = V2.zero;
    left_button = false; middle_button = false; right_button = false;
    cursor = V2.zero; last_cursor = V2.zero; delta = V2.zero;
    screen_cursor = V2.zero; last_screen_cursor = V2.zero; screen_delta = V2.zero;
  }

let set_input_char i x b = {i with char_states = ('b',true)} (*map.insert x b (char_states i)*)

(********************************************************)

module Engine = struct
  type t = int
end
type engine = Engine.t

(* let update_game g tick =
 *   Sdl.log "Update game %f" tick *)

module Machine = struct
  type t = {
      last_time: float;
      running: bool;
      tick_mul: float;
      input_state: input;
    } [@@deriving sexp]

  let create g = {
      last_time = Unix.gettimeofday();
      running = false;
      tick_mul = 1.0;
      input_state = no_input;
    }

  let step en =
    let before = en.last_time in
    (* let now = Int32.to_int (Sdl.get_ticks ()) in *)
    let now = Unix.gettimeofday () in
    let tick = (now -. before) in
    (* Sdl.log "last %f now %f tick %f" before now tick; *)
    { en with
      last_time = now;
      (* game = (update_game en.game ((tick *. en.tick_mul) /. 1000.)); *)
    }
end

(***********************************)

type model = {
    windings: Geom.Winding.t
  }

module type Scene = sig
  type t
  val start: unit -> t
  val step: t -> t
  val cleanup: t -> unit
end

module Scene = struct
  (* let render s = List.map Part.render s.parts *)
end
               
module type Game = sig
  (* a Play *)
  type t
  (*type scenes = Scene list*)
  (* clock, heart, breath, rhythm, beat *)
  val initial_state: unit -> t
  val step: t -> t
  val render: t -> unit
  val cleanup: t -> unit
end





