open Tgl3

module Nova = struct
  include Nova_util
  include Nova_math
  include Nova_input

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

  (* let createBuffer = function
   *     Image -> 0
   *   | Framebuffer -> 1 *)
               
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

end

(*
  (*
  let init = foreign "NV_Init" (int @-> int @-> returning void)
  let shutdown = foreign "NV_Shutdown" (void @-> returning void)
  let update = foreign "NV_Update" (int @-> returning int)
   *)

  external init : int -> int -> unit = "NV_Init" [@@noalloc]
  external update : unit -> bool = "NV_Update" [@@noalloc]
  external endFrame : unit -> unit = "NV_EndFrame" [@@noalloc]
  external getTime : unit -> float = "NV_GetTime" [@@noalloc]
  external shutdown : unit -> unit = "NV_Shutdown" [@@noalloc]
 *)
