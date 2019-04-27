(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

open Gg

module Input = struct
  type t = {
      up_arrow: bool; down_arrow: bool; left_arrow: bool; right_arrow: bool;
      char_states: char * bool;
      move_vector: v2;
        
      left_button: bool; middle_button: bool; right_button: bool;

      (*type cursor = {
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
end
