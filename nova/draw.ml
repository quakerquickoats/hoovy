(*
  Gamelike
  (c) 2019 Lyndon Tremblay
 *)

open Gg

module Make(C: JsOfOCairo.S) = struct
  let text c s =
    C.set_font_size c 22.;
    (* 
       agh ! monospace is just [][][][] blocks.
       dejavu is completely reversed from RtoL.
       courier is a little few pixels
       clean is completely fixed up for LtoR !

        ... there must be a good one.
        for now, we reverse strings and it works for all.
     *)
    (* C.select_font_face c "dejavu"; *)
    C.show_text c s
    
  let testArc c =
    C.save c;
    C.arc c 50. 50. ~r:40. ~a1:0. ~a2:5.;
    C.stroke c;
    C.set_source_rgb c 1. 1. 1.;
    C.move_to c 200. 200.;
    text c "תיבףלא";
    C.restore c

  let clear c =
    (* clear the layer *)
    C.set_source_rgba c 0. 0. 0. 0.;
    C.set_operator c C.SOURCE;
    C.paint c;
    C.set_operator c C.OVER

  let withState c f =
    C.save c;
    f c;
    C.restore c

  (* let lineRect c {x;y;w;h} =
   *   C.move_to *)

  let moveTo c v =
    C.move_to c (V2.x v) (V2.y v)
    
  let part c p =
    C.save c;
    C.set_source_rgba c 0. 0.5 1. 1.;
    moveTo c (Nova.Engine.Part.origin p);
    C.set_font_size c 32.;
    C.show_text c (string_of_float (Nova.Engine.Part.number p));
    C.restore c;
end


(* let () = begin
  let module Nova = Nova.Make(CairoMock) in
  let ctx = CairoMock.create () in
  Nova.draw ctx;
  assert (CairoMock.calls ctx =
    ["save";
     "arc 50.00 50.00 ~r:40.00 ~a1:0.00 ~a2:5.00";
     "stroke"; "restore"])
end
*)
