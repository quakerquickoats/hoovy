let () = Findlib.init ()
let showNova () =
  let pkgs =
    List.filter
      (fun pkg ->
        4 <= String.length pkg && String.sub pkg 0 4 = "nova")
      (Fl_package_base.list_packages())
  in
  pkgs
  (* Fl_dynload.load_packages pkgs *)
