(* let make_socket addr port =
  s
  *)

open Lwt

let client host port =
  Printf.printf "Client mode: Establishing connectiong with `%s:%i' ...\n" host port

let accept_connection _conn =
  return
  
let tcp_server addr port =
  let sock = 
    let open Lwt_unix in
    let s = socket PF_INET SOCK_STREAM 0 in
    bind s @@ ADDR_INET(addr, port);
    listen s 10; (* backlog *)
    s in
  let rec serve () =
    Lwt_unix.accept sock >>= accept_connection >>= serve
  in serve

let server port =
  Lwt_main.run @@ (tcp_server Unix.inet_addr_loopback port) ()

 

