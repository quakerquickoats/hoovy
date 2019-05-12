(*
  Novapilot
  (c) 2019 Lyndon Tremblay
 *)

open Tgl3

let get_int =
  let a = Bigarray.(Array1.create int32 c_layout 1) in
  fun f -> f a; Int32.to_int a.{0}

(* let set_int =
 *   let a = Bigarray.(Array1.create int32 c_layout 1) in
 *   fun f i -> a.{0} <- Int32.of_int i; f a *)

(* let deleteBuffer = function
 *     (Image {id;_}) -> set_int (Gl.delete_textures 1) id
 *   | (Framebuffer {id;_}) -> set_int (Gl.delete_framebuffers 1) id *)
   
let createShader () =
  let p = Gl.create_program () in
  let cs p x str = begin
      let sh = Gl.create_shader x in
      Gl.shader_source sh str;
      Gl.compile_shader sh;
      Gl.attach_shader p sh
    end
  in
  cs p Gl.vertex_shader
    {|#version 150 core
     out vec2 tc;
     void main(){
     tc = vec2((gl_VertexID & 2)>>1, 1-(gl_VertexID & 1));
     //gl_Position = vec4(tc*2.0-1.0,0,1);
     gl_Position = vec4(tc*2.0-1, 0, 1);}
     |};
  cs p Gl.fragment_shader
    {|#version 150 core
     uniform sampler2D tex;
     in vec2 tc;
     out vec4 color;
     void main() {
     color = texture(tex,tc*vec2(1.0,-1.0));}
     |};
  Gl.link_program p;
  Gl.use_program p;
  p

let createLayer w h image =
  let vao = get_int (Gl.gen_vertex_arrays 1) in
  Gl.bind_vertex_array vao;
  let tex = get_int (Gl.gen_textures 1) in
  Gl.bind_texture Gl.texture_2d tex;
  Gl.(tex_parameteri texture_2d texture_max_level 0);
  Gl.(tex_parameteri texture_2d texture_min_filter linear);
  Gl.(tex_parameteri texture_2d texture_mag_filter linear);
  Gl.pixel_storei Gl.unpack_alignment 1;
  Gl.(tex_image2d texture_2d 0 rgba w h 0 rgba
        unsigned_byte (`Data (Cairo.Image.get_data8 image)));
  (* Image {id= tex; width= w; height= h} *)
  tex

let updateLayer id width height image =
  Cairo.Surface.flush image;
  Gl.(bind_texture texture_2d id);
  Gl.(tex_sub_image2d texture_2d 0 0 0 width height rgba
        unsigned_byte (`Data (Cairo.Image.get_data8 image)))

let initFrame w h =
  Gl.(disable depth_test);
  Gl.(enable blend);
  Gl.(blend_func src_alpha one_minus_src_alpha);
  (*Gl.(enable texture_2d);*)
  Gl.viewport 0 0 w h;
  Gl.clear_color 1. 0.5 1. 1.;
  Gl.clear Gl.color_buffer_bit;
  Gl.draw_arrays Gl.triangle_strip 0 4

(* 
   GL Stuff 

  let deleteBuffer = function
      (Image {id;_}) -> set_int (Gl.delete_textures 1) id
    | (Framebuffer {id;_}) -> set_int (Gl.delete_framebuffers 1) id
                            

  let createTexture width height data =
    let id = get_int (Gl.gen_textures 1) in
    Gl.bind_texture Gl.texture_2d id;
    Gl.(tex_parameteri texture_2d texture_min_filter linear);
    Gl.(tex_parameteri texture_2d texture_mag_filter linear);
    Gl.(tex_image2d texture_2d 0 rgba width height
          0 bgra unsigned_byte (`Data (Cairo.Image.get_data8 data)));
    Image {id; width; height}

    (*
  let createBuffer b =
    let id = get_int (Gl.gen_buffers 1) in
    let bytes = Gl.bigarray_byte_size b in
    Gl.bind_buffer Gl.array_buffer id;
    Gl.buffer_data Gl.array_buffer bytes (Some b) Gl.static_draw;
    id

  let deleteBuffer =
    set_int (Gl.delete_buffers 1)

  let set_3d ba i x y z =
    let start = i * 3 in
    ba.{start} <- x; ba.{start + 1} <- y; ba.{start + 2} <- z

  let vertices =
    let vs = Bigarray.(Array1.create float32 c_layout (3 * 3)) in
    set_3d vs 0 (-0.8) (-0.8) 0.0;
    set_3d vs 1 0.8    (-0.8) 0.0;
    set_3d vs 2 0.0    0.8    0.0;
    vs

  let colors =
    let cs = Bigarray.(Array1.create float32 c_layout (3 * 3)) in
    set_3d cs 0 1.0 0.0 0.0;
    set_3d cs 1 0.0 1.0 0.0;
    set_3d cs 2 0.0 0.0 1.0;
    cs

  let indices =
    let is = Bigarray.(Array1.create int8_unsigned c_layout 3) in
    set_3d is 0 0 1 2;
    is
  
  (* let createModel indices vertices colors texcoords = *)
  let createModel () = 
    let gID = get_int (Gl.gen_vertex_arrays 1) in
    let iID = createBuffer indices in
    let vID = createBuffer vertices in
    let cID = createBuffer colors in
    (* let tID = createBuffer texcoords in *)
    let bind_attrib id loc dim typ =
      Gl.bind_buffer Gl.array_buffer id;
      Gl.enable_vertex_attrib_array loc;
      Gl.vertex_attrib_pointer loc dim typ false 0 (`Offset 0);
    in
    Gl.bind_vertex_array gID;
    Gl.bind_buffer Gl.element_array_buffer iID;
    bind_attrib vID 0 3 Gl.float;
    bind_attrib cID 1 3 Gl.float;
    Gl.bind_vertex_array 0;
    Gl.bind_buffer Gl.array_buffer 0;
    Gl.bind_buffer Gl.element_array_buffer 0;
    (gID, [iID; vID; cID; 0]) (* tID *)

  let drawModel gID =
    Gl.bind_vertex_array gID;
    Gl.draw_elements Gl.triangles 3 Gl.unsigned_byte (`Offset 0);
    Gl.bind_vertex_array 0
     *)

  let createFramebuffer _w _h =
    let id = get_int (Gl.gen_framebuffers 1) in
    Gl.bind_framebuffer Gl.framebuffer id;
    Framebuffer {id}

  let withBuffer f = function
      (Image {id;_}) -> begin
        Gl.bind_texture Gl.texture_2d id;
        f;
        Gl.bind_texture Gl.texture_2d 0
      end
    | (Framebuffer {id;_}) -> begin
        Gl.bind_framebuffer Gl.framebuffer id;
        f;
        Gl.bind_framebuffer Gl.framebuffer 0
      end
    
  let prepareScene w h =
    Gl.(disable depth_test);
    Gl.(enable blend);
    Gl.(blend_func src_alpha one_minus_src_alpha);
    (*Gl.(enable texture_2d);*)
    Gl.viewport 0 0 w h;
    Gl.clear_color 1. 0.5 1. 1.;
    Gl.(clear color_buffer_bit)

*)

                                 
