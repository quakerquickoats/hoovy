
(*
let make_socket addr port =
  let open Lwt_unix in
  let s = socket PF_INET SOCK_STREAM 0 in
  bind s @@ ADDR_INET(addr, port);
  listen s backlog;
  s

let server addr port =
  Printf.printf "Server mode: Listening on `%s:%i'.\n" addr port

 *)

open Lwt
open Cohttp
open Cohttp_lwt_unix

let client addr port =
  Printf.printf "Client mode: Establishing connection with `%s:%i' ...\n" addr port

  
let server port =
  let callback _conn req body =
    let uri = req |> Request.uri |> Uri.to_string in
    let meth = req |> Request.meth |> Code.string_of_method in
    let headers = req |> Request.headers |> Header.to_string in
    body |> Cohttp_lwt.Body.to_string >|= (fun body ->
      (Printf.sprintf "Uri: %s\nMethod: %s\nHeaders: %s\nBody: %s" uri meth headers body))
    >>= (fun body -> Server.respond_string ~status:`OK ~body ())
  in
  Server.create ~mode:(`TCP (`Port port)) (Server.make ~callback ())
  
let () =
  let port = 9999 in
  if Array.length Sys.argv > 1 then
    client Sys.argv.(1) port
  else
    let addr = (Unix.string_of_inet_addr Unix.inet_addr_loopback) in
    let _s = server port in
    Printf.printf "Server mode: Listening on `%s:%i'.\n" addr port

