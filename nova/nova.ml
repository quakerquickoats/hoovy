open Ctypes
open Foreign

module Nova = struct
  let init = foreign "NV_Init" (void @-> returning void)
  let shutdown = foreign "NV_Shutdown" (void @-> returning void)
end
                
