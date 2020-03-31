
(* [incomplete]
   template for example expansion using HTTP for web browser UI. *)

open Lwt
open Cohttp
open Cohttp_lwt_unix

let web_client host port =
  let uri = "http://" ^ host ^ ":" ^ (Int.to_string port) in
  Printf.printf "Client mode: Establishing connection with `%s' ...\n" uri;
  Client.put (Uri.of_string uri) >>= fun (_resp, body) ->
  body |> Cohttp_lwt.Body.to_string >|= fun body -> body  

let web_server port =
  let callback _conn req body =
    let uri = req |> Request.uri |> Uri.to_string in
    let meth = req |> Request.meth |> Code.string_of_method in
    let headers = req |> Request.headers |> Header.to_string in
    body |> Cohttp_lwt.Body.to_string >|= (fun body ->
      (Printf.sprintf "Uri: %s\nMethod: %s\nHeaders: %s\nBody: %s" uri meth headers body))
    >>= (fun body -> Server.respond_string ~status:`OK ~body ())
  in
  Server.create ~mode:(`TCP (`Port port)) (Server.make ~callback ())


let client host port =
  ignore (Lwt_main.run (web_client host port))
  
let server port =
  ignore (Lwt_main.run (web_server port))
