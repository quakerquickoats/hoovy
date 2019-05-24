open Foreign
open Ctypes

(* let em_callback_func = void @-> returning void
 * let emscriptenSetMainLoop =
 *   foreign "emscripten_set_main_loop"
 *     (funptr em_callback_func @->
 *        int @-> int @-> returning void) *)
   
(**********************)
(* Some basic Defines *)
(**********************)
let pi = 3.14159265358979323846
let deg2rad = pi/.180.
let rad2deg = 180./.pi

(* raylib Config Flags *)
let flag_ShowLogo = 1
let flag_FullscreenMode = 2
let flag_WindowResizable = 4
let flag_WindowUndecorated = 8
let flag_WindowTransparent = 16
let flag_MSAA4XHint = 32
let flag_VSyncHint = 64

(* Keyboard Function Keys *)

(* Some Basic Colors *)
type color
let color: color structure typ = structure "Color"
let color_r = field color "r" char
let color_g = field color "g" char
let color_b = field color "b" char
let color_a = field color "a" char
let () = seal color
let makeColor (r,g,b,a) =
  let c = make color in 
  setf c color_r r;
  setf c color_g g;
  setf c color_b b;
  setf c color_a a;
  c

let lightGray = makeColor ('\200','\200','\200','\255')

(* Shader and material limits *)
let maxShaderLocations = 32
let maxMaterialMaps = 12
              
(*************************)
(* Structures Definition *)
(*************************)
              
type vector2
let vector2: vector2 structure typ = structure "Vector2"
let vector2_x = field vector2 "x" float
let vector2_y = field vector2 "y" float
let () = seal vector2
let makeVector2 (x,y) =
  let v = make vector2 in
  setf v vector2_x x;
  setf v vector2_y y;
  v
              
type vector3
let vector3: vector3 structure typ = structure "Vector3"
let vector3_x = field vector3 "x" float
let vector3_y = field vector3 "y" float
let vector3_z = field vector3 "z" float
let () = seal vector3
let makeVector3 (x,y,z) =
  let v = make vector3 in
  setf v vector3_x x;
  setf v vector3_y y;
  setf v vector3_z z;
  v

type vector4
let vector4: vector3 structure typ = structure "Vector4"
let vector4_x = field vector4 "x" float
let vector4_y = field vector4 "y" float
let vector4_z = field vector4 "z" float
let vector4_w = field vector4 "w" float
let () = seal vector4
let makeVector4 (x,y,z,w) =
  let v = make vector4 in
  setf v vector4_x x;
  setf v vector4_y y;
  setf v vector4_z z;
  setf v vector4_w w;
  v

type quaternion = vector4

type matrix
let matrix: matrix structure typ = structure "Matrix"
let m0 = field matrix "m0" float
let m1 = field matrix "m1" float
let m2 = field matrix "m2" float
let m3 = field matrix "m3" float
let m4 = field matrix "m4" float
let m5 = field matrix "m5" float
let m6 = field matrix "m6" float
let m7 = field matrix "m7" float
let m8 = field matrix "m8" float
let m9 = field matrix "m9" float
let m10 = field matrix "m10" float
let m11 = field matrix "m11" float
let m12 = field matrix "m12" float
let m13 = field matrix "m13" float
let m14 = field matrix "m14" float
let m15 = field matrix "m15" float
let () = seal matrix
(* let makeMatrix (m0,m4,m5,m6,m7,m8,m9 ...*)

(* [Color is up above] *)

type rectangle
let rectangle: rectangle structure typ = structure "Rectangle"
let rectangle_x  = field rectangle "x" float
let rectangle_y = field rectangle "y" float
let rectangle_width = field rectangle "width" float
let rectangle_height = field rectangle "height" float
let () = seal rectangle
let makeRectangle (x,y,w,h) =
  let r = make rectangle in
  setf r rectangle_x x;
  setf r rectangle_y y;
  setf r rectangle_width w;
  setf r rectangle_height h;
  r
       
type image
let image: image structure typ = structure "Image"
let image_data = field image "y" (ptr void)
let image_width = field image "width" int
let image_height = field image "height" int
let image_mipmaps = field image "mipmaps" int
let image_format = field image "format" int
let () = seal image
let makeImage data w h mipmaps format =
  let i = make image in
  setf i image_data data;
  setf i image_width w;
  setf i image_height h;
  setf i image_mipmaps mipmaps;
  setf i image_format format;
  i

type texture2d
let texture2d: texture2d structure typ = structure "Texture2D"
let texture2d_id = field texture2d "id" int
let texture2d_width = field texture2d "width" int
let texture2d_height = field texture2d "height" int
let texture2d_mipmaps = field texture2d "mipmaps" int
let texture2d_format = field texture2d "format" int
let () = seal texture2d
let makeTexture2d id w h mipmaps format =
  let t = make texture2d in
  setf t texture2d_id id;
  setf t texture2d_width w;
  setf t texture2d_height h;
  setf t texture2d_mipmaps mipmaps;
  setf t texture2d_format format;
  t

type renderTexture2d
let renderTexture2d: renderTexture2d structure typ =
  structure "RenderTexture2D"
let renderTexture2d_id = field renderTexture2d "id" int
let renderTexture2d_texture = field renderTexture2d "texture" texture2d
let renderTexture2d_depth = field renderTexture2d "depth" texture2d
let () = seal renderTexture2d

type renderTexture = renderTexture2d

(* N-Patch layout info .... *)
type npatchInfo
   
(* Font character info .... *)
type charInfo
   
(* Font type ..... *)
type font

type spriteFont = font

type camera3d
let camera3d: image structure typ = structure "Camera3D"
let camera3d_position  = field camera3d "offset" vector3
let camera3d_target = field camera3d "target" vector3
let camera3d_up = field camera3d "up" vector3
let camera3d_fovy = field camera3d "fovy" float
let camera3d_type = field camera3d "type" int
let () = seal camera3d

type camera2d
let camera2d: camera2d structure typ = structure "Camera2D"
let camera2d_offset  = field camera2d "offset" vector2
let camera2d_target = field camera2d "target" vector2
let camera2d_rotation = field camera2d "rotation" float
let camera2d_zoom = field camera2d "zoom" float
let () = seal camera2d
(* let makeCamera2d () =
 *   let c = make color in 
 *   setf c color_r r; *)

type camera = camera3d
let camera = camera3d

type boundingBox
let boundingBox: boundingBox structure typ = structure "BoundingBox"
let boundingBox_min  = field boundingBox "min" vector3
let boundingBox_max  = field boundingBox "max" vector3
let () = seal boundingBox

(* Vertex data defining a mesh ........ *)
type mesh

(* Shader type (generic) .... *)
type shader

(* Material texture map .... *)
type materialMap

(* Material type (generic) *)
type material

(* Model type .... *)
type model

(* Ray type .... *)
type ray

(* Raycast hit information .... *)
type rayHitInfo

(* Wave type ..... *)
type wave

(* Sound source type .... *)
type sound

(* Music type ???... *)
type musicData

(* Audio stream type *)
type audioStream

(* Head-Mounted-Display *)
type vrDeviceInfo

(**************************)
(* Enumerators Definition *)
(**************************)

(* Trace log type *)
let logInfo = 1
let logWarning = 2
let logError = 4
let logDebug = 8
let logOther = 16

(* Shader location point type *)
let locVertexPosition = 0
let locVertexTexCoord01 = 1
let locVertexTexCoord02 = 2
let locVertexNormal = 3
let locVertexTangent = 4
let locVertexColor = 5
let locMatrixMVP = 6
let locMatrixModel = 7
let locMatrixView = 8
let locMatrixProjection = 9
let locVectorView = 10
let locColorDiffuse = 11
let locColorSpecular = 12
let locColorAmbient = 13
let locMapAlbedo = 14 and locMapDiffuse = 14
let locMapMetalness = 15 and locMapSpecular = 15
let locMapNormal = 16
let locMapRoughness = 17
let locMapOcclusion = 18
let locMapEmission = 19
let locMapHeight = 20
let locMapCubemap = 21
let locMapIrradiance = 22
let locMapPrefilter = 23
let locMapBRDF = 24

(* Material map type *)
let mapAlbedo = 0 and mapDiffuse = 0
let mapMetalness = 1 and mapSpecular = 1
let mapNormal = 2
let mapRoughness = 3
let mapOcclusion = 4
let mapEmission = 5
let mapHeight = 6
let mapCubemap = 7
let mapIrradiance = 8
let mapPrefilter = 9
let mapBRDF = 10

(* Pixel formats *)
            

(******************************************)
            
let foreign_void x = foreign x (void @-> returning void)
let foreign_bool x = foreign x (void @-> returning bool)

(* Window-related functions *)
let initWindow =
  foreign "InitWindow" (int @-> int @-> string @-> returning void)
let closeWindow = foreign_void "CloseWindow"
let isWindowReady = foreign_bool "IsWindowReady"
let windowShouldClose = foreign_bool "WindowShouldClose"
let isWindowMinimized = foreign_void "IsWindowMinimized"
let toggleFullscreen = foreign_void "ToggleFullscreen"
let setWindowIcon = foreign "SetWindowIcon" (image @-> returning void)
let setWindowTitle = foreign "SetWindowTitle" (string @-> returning void)
let setWindowPosition = foreign "SetWindowPosition"
                          (int @-> int @-> returning void)
let setWindowMonitor = foreign "SetWindowMonitor" (int @-> returning void)
let setWindowMinSize = foreign "SetWindowMinSize"
                     (int @-> int @-> returning void)
let setWindowSize = foreign "SetWindowSize"
                      (int @-> int @-> returning void)
let getScreenWidth = foreign "GetScreenWidth" (void @-> returning int)
let getScreenHeight = foreign "GetScreenHeight" (void @-> returning int)
                     
(* Cursor-related functions *)
let showCursor = foreign_void "ShowCursor"
let hideCursor = foreign_void "HideCursor"
let isCursorHidden = foreign_bool "IsCursorHidden"
let enableCursor = foreign_void "EnableCursor"
let disableCursor = foreign_void "DisableCursor"

(* Drawing-related functions *)
let clearBackground = foreign "ClearBackground" (color @-> returning void)
let beginDrawing = foreign_void "BeginDrawing"
let endDrawing = foreign_void "EndDrawing"
let beginMode2D = foreign "BeginMode2D" (camera2d @-> returning void)
let endMode2D = foreign_void "EndMode2D"
let beginMode3D = foreign "BeginMode3D" (camera3d @-> returning void)
let endMode3D = foreign_void "EndMode3D"
let beginTextureMode = foreign "BeginTextureMode"
                         (renderTexture2d @-> returning void)
let endTextureMode = foreign_void "EndTextureMode"
                                                
(* Screen-space-related functions *)

(* timing-related functions *)
let setTargetFPS = foreign "SetTargetFPS"(int @-> returning void)
let getFPS = foreign "GetFPS" (void @-> returning int)
let getFrameTime = foreign "GetFrameTime" (void @-> returning float)
let getTime = foreign "GetTime" (void @-> returning double)

(* Color-related functions *)
let colorToInt = foreign "ColorToInt" (color @-> returning int)
let colorNormalize = foreign "ColorNormalize" (color @-> returning vector4)
let colorToHSV = foreign "ColorToHSV" (color @-> returning vector4)
let getColor = foreign "GetColor" (int @-> returning color)
let fade = foreign "Fade" (color @-> float @-> returning color)

(* Misc. functions *)
let showLogo = foreign_void "ShowLogo"
let setConfigFlags = foreign "SetConfigFlags" (char @-> returning void)
let setTraceLog = foreign "SetTraceLog" (char @-> returning void)
let takeScreenshot = foreign "TakeScreenshot" (string @-> returning void)

(* Files management functions *)

(* Persistent storage management *)
let storageSaveValue = foreign "StorageSaveValue"
                         (int @-> int @-> returning void)
let storageLoadValue = foreign "StorageLoadValue" (int @-> returning int)

(****************************)
(* Input Handling Functions *)
(****************************)

(* keyboard *)

let () = ()
           (* gamepad *)
           (* mouse *)
           (* touch *)

(******************************)
(* Gesture Handling Functions *)
(******************************)

(***************************)
(* Camera System Functions *)
(***************************)
let setCameraMode = foreign "SetCameraMode"
                      (camera @-> int @-> returning void)
           
let updateCamera = foreign "UpdateCamera" (ptr camera @-> returning void)
let setCameraPanControl = foreign "SetCameraPanControl"
                            (int @-> returning void)
let setCameraAltControl = foreign "SetCameraAltControl"
                            (int @-> returning void)
let setCameraSmoothZoomControl = foreign "SetCameraSmoothZoomControl"
                                   (int @-> returning void)
let setCameraMoveControls = foreign "SetCameraMoveControls"
                              (int @-> int @-> int @-> int @->
                                 int @-> int @-> returning void)

(****************************)
(* Shapes Drawing Functions *)
(****************************)

                              
