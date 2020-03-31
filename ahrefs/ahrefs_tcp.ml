(* let make_socket addr port =
  let open Lwt_unix in
  let s = socket PF_INET SOCK_STREAM 0 in
  bind s @@ ADDR_INET(addr, port);
  listen s backlog;
  s
  *)
  
let client addr port =
  Printf.printf "Client mode: Establishing connectiong with `%s:%i' ...\n" addr port
  
let server _port =
  ()

 

