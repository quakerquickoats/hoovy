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
  Cairo.scale c 1. 1.;

  Draw.scene c;
  Cairo.Surface.flush i;
  (* Cairo.Surface.finish i; *)

  (*  let fbo = Bigarray.(Array1.create Int32 c_layout 1) in
  Gl.gen_framebuffers 1 fbo;*)
  (* let tex = Nova.createTexture w h i in
  let (gID,_) = Nova.createModel () in *)
  (* let fb = Nova.createFramebuffer w h in *)
  let p = Gl.create_program () in
  let cs p x str = begin
      let sh = Gl.create_shader x in
      Gl.shader_source sh str;
      Gl.compile_shader sh;
      Gl.attach_shader p sh
    end in
  cs p Gl.vertex_shader "#version 150 core\nout vec2 tc;void main(){tc=vec2( (gl_VertexID & 2)>>1, 1 - (gl_VertexID & 1)); gl_Position=vec4(tc*2.0-1.0,0,1);}";
  cs p Gl.fragment_shader "#version 150 core\nuniform sampler2D tex;in vec2 tc;out vec4 color; void main() {color=texture(tex,tc);}";
  System.checkErrors "prelink";
  Gl.link_program p;
  Gl.use_program p;
  System.checkErrors "postlink";
  let vao = Priv.get_int (Gl.gen_vertex_arrays 1) in
  Gl.bind_vertex_array vao;
  let tex = Priv.get_int (Gl.gen_textures 1) in
  Gl.bind_texture Gl.texture_2d tex;
  
  System.checkErrors "tex";

  Gl.(tex_parameteri texture_2d texture_max_level 0);
  Gl.(tex_parameteri texture_2d texture_min_filter linear);
  Gl.(tex_parameteri texture_2d texture_mag_filter linear);
  Gl.pixel_storei Gl.unpack_alignment 1;
  Gl.(tex_image2d texture_2d 0 rgb w h 0 rgba unsigned_byte
        (`Data (Cairo.Image.get_data8 i)));

  System.checkErrors "afterall";

  while System.update s do
    Gl.clear_color 1. 0.5 1. 1.;
    Gl.clear Gl.color_buffer_bit;
    Gl.draw_arrays Gl.triangle_strip 0 4;
    (*
      Nova.prepareScene w h;
    Nova.bindTexture tex; *)

    (* Nova.withFramebuffer fb (fun () ->
     *   ); *)


    (* Nova.drawModel gID; *)
    
    System.endFrame s;
  done;

  Cairo.PNG.write i "novapilot_cli.png";
  System.shutdown s
    


(* let () = begin
  let module Nova = Nova.Make(CairoMock) in
  let ctx = CairoMock.create () in
  Nova.draw ctx;
  assert (CairoMock.calls ctx = ["save"; "arc 50.00 50.00 ~r:40.00 ~a1:0.00 ~a2:5.00"; "stroke"; "restore"])
end
*)
