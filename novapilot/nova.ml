(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

module Make(C: JsOfOCairo.S) = struct
  let draw c =
    C.save c;
    C.arc c 50. 50. ~r:40. ~a1:0. ~a2:5.;
    C.stroke c;

    C.set_source_rgb c 1. 1. 1.;
    C.select_font_face c "monospace";
    C.set_font_size c 20.;
    C.move_to c 22. 22.;
    C.show_text c "אלף-בית";

    C.restore c
end
