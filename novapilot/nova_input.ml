(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

open Gg

module Input = struct

  type cursor = {
      current: v2;
      previous: v2;
      delta: v2;
    }
              
  type t = {
      upArrow: bool;
      downArrow: bool;
      leftArrow: bool;
      rightArrow: bool;

      char_states: char * bool;
      move_vector: v2;
        
      leftButton: bool;
      middleButton: bool;
      rightButton: bool;

      (*type cursor = {
        c: V2;     
        last: V2;  
        delta: V2; 
        } *)
      cursor: cursor;
      screenCursor: cursor;
(*      cursor: v2; last_cursor: v2; delta: v2;
      screen_cursor: v2; last_screen_cursor: v2; screen_delta: v2;*)
    }

  let no_input = {
      upArrow = false;
      downArrow = false;
      leftArrow = false;
      rightArrow = false;
      
      char_states = ('a',false);
      move_vector = V2.zero;
      
      leftButton = false;
      middleButton = false;
      rightButton = false;

      cursor = {current = V2.zero;
                previous = V2.zero;
                delta = V2.zero};
      screenCursor = {current = V2.zero;
                      previous = V2.zero;
                      delta = V2.zero};
                  (*
      cursor = V2.zero;
      last_cursor = V2.zero;
      delta = V2.zero;
      screen_cursor = V2.zero;
      last_screen_cursor = V2.zero;
      screen_delta = V2.zero;*)
    }
                 
  let set_input_char i _x _b = {i with char_states = ('b',true)}
                                 (*map.insert x b (char_states i)*)
end
                        
