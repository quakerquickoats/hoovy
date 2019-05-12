(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

open System_glfw

module Draw = Draw.Make(Cairo)

open Tgl3

module Priv = struct
  type x =
    | Image of
        {id:int;
         width:int;
         height:int}
    | Framebuffer of
        {id:int}

  let get_int =
    let a = Bigarray.(Array1.create int32 c_layout 1) in
    fun f -> f a; Int32.to_int a.{0}

  let set_int =
    let a = Bigarray.(Array1.create int32 c_layout 1) in
    fun f i -> a.{0} <- Int32.of_int i; f a

  let deleteBuffer = function
      (Image {id;_}) -> set_int (Gl.delete_textures 1) id
    | (Framebuffer {id;_}) -> set_int (Gl.delete_framebuffers 1) id
end
   
let () =
  let w, h = 320, 240 in
  let s = System.init w h "Novapilot" in

  let i = Cairo.Image.(create ARGB32 ~w ~h) in
  let c = Cairo.create i in
  (* Cairo.set_source_rgba c 0. 0. 1. 1.;
   * Cairo.fill c;
   * Cairo.scale c 1. 1.; *)

  Draw.scene c;
  Cairo.Surface.flush i;
  (* Cairo.Surface.finish i; *)

  let p = Gl.create_program () in
  let cs p x str = begin
      let sh = Gl.create_shader x in
      Gl.shader_source sh str;
      Gl.compile_shader sh;
      Gl.attach_shader p sh
    end in
  
  cs p Gl.vertex_shader {|#version 150 core
                         out vec2 tc;
                         void main(){
                         tc = vec2((gl_VertexID & 2)>>1, 1-(gl_VertexID & 1));
                         //gl_Position = vec4(tc*2.0-1.0,0,1);
                         gl_Position = vec4(tc*2.0-1, 0, 1);
                         }
                         |};
  cs p Gl.fragment_shader {|#version 150 core
                           uniform sampler2D tex;
                           in vec2 tc;
                           out vec4 color;
                           void main() {
                           color = texture(tex,tc*1.0);}
                           |};
  Gl.link_program p;
  Gl.use_program p;
  let vao = Priv.get_int (Gl.gen_vertex_arrays 1) in
  Gl.bind_vertex_array vao;
  let tex = Priv.get_int (Gl.gen_textures 1) in
  Gl.bind_texture Gl.texture_2d tex;
  Gl.(tex_parameteri texture_2d texture_max_level 0);
  Gl.(tex_parameteri texture_2d texture_min_filter linear);
  Gl.(tex_parameteri texture_2d texture_mag_filter linear);
  Gl.pixel_storei Gl.unpack_alignment 1;
  Gl.(tex_image2d texture_2d 0 rgba w h 0 rgba unsigned_byte
        (`Data (Cairo.Image.get_data8 i)));

  Gl.(disable depth_test);
  Gl.(enable blend);
  Gl.(blend_func src_alpha one_minus_src_alpha);
  (*Gl.(enable texture_2d);*)
  Gl.viewport 0 0 w h;
  Gl.clear_color 1. 0.5 1. 1.;

  let rec loop s lastTime =
    let now = System.getTime () in
    let tick = now -. lastTime in
    if System.update s then begin
        Cairo.save c;
        Cairo.set_source_rgb c 0. 0. 0.;
        Cairo.paint c;
        Cairo.set_source_rgb c 0. 1. 1.;
        Cairo.set_font_size c 22.;
        Cairo.move_to c 44. 44.;
        Cairo.show_text c (string_of_float (1. /. tick));
        Cairo.restore c;
        Cairo.Surface.flush i;

        (* texture should already be bound. *)
        Gl.(tex_sub_image2d texture_2d 0 0 0 w h rgba unsigned_byte (`Data (Cairo.Image.get_data8 i)));
        
        Gl.clear Gl.color_buffer_bit;
        Gl.draw_arrays Gl.triangle_strip 0 4;
        System.endFrame s;
        loop s now
      end
    else
      ()
  in
  loop s (System.getTime());
        
  Cairo.PNG.write i "novapilot_cli.png";
  System.shutdown s
    


(* let () = begin
  let module Nova = Nova.Make(CairoMock) in
  let ctx = CairoMock.create () in
  Nova.draw ctx;
  assert (CairoMock.calls ctx = ["save"; "arc 50.00 50.00 ~r:40.00 ~a1:0.00 ~a2:5.00"; "stroke"; "restore"])
end
*)
