(* let make_socket addr port =
  s
  *)

open Unix
open Printf

let client host port =
  printf "Client mode: Establishing connectiong with `%s:%i' ...\n" host port

let accept_connection _conn =
  printf "Accept connection.\n";
  () 
  
let tcp_server addr port =
  let sock = socket PF_INET SOCK_STREAM 0 in
  setsockopt sock SO_REUSEADDR true;
  bind sock (ADDR_INET (addr, port));
  listen sock 10; (* backlog *)
  let rec serve () =
    let c = accept sock in
    accept_connection c;
    serve ()
  in serve ()

let server port =
  Lwt_main.run (tcp_server inet_addr_loopback port)

 

