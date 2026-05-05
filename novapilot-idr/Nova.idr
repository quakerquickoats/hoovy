module Nova

rlib : String -> String
rlib s = "C" ++ s ++ ",libraylib"

%foreign rlib "SetTraceLogLevel"
setTraceLogLevel : Int -> PrimIO ()

%foreign rlib "InitWindow"
initWindow : Int -> Int -> String -> PrimIO ()

%foreign rlib "SetTargetFPS"
setTargetFPS : Int -> PrimIO ()

%foreign rlib "CloseWindow"
closeWindow : PrimIO ()

--------------------------

main : IO ()
main = putStrLn "Hello World!"

test : IO ()
test = primIO $ do
  setTraceLogLevel 1
  initWindow 200 200 "Novapilot?"
  
  setTargetFPS 30
  closeWindow
