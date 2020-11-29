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

      cursor: cursor;
      screenCursor: cursor;
    }

  let noInput = {
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
    }
                 
  let set_input_char i _x _b = {i with char_states = ('b',true)}
                                 (*map.insert x b (char_states i)*)
end
                        
