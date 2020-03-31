open Ahrefs_tcp
(* open Ahrefs_web *)

let () =
  let port = 9999 in
  if Array.length Sys.argv > 1 then
    client Sys.argv.(1) port
  else
    let addr = (Unix.string_of_inet_addr Unix.inet_addr_loopback) in
    Printf.printf "Server mode: Listening on `%s:%i'.\n" addr port;
    server port;
  print_endline "---------Finished."
