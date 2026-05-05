(* tanach_fetch.ml
   Fetch and parse tanach.us Server.txt output.
   Requires: cohttp-lwt-unix, lwt, re *)

(* tanach_fetch.ml *)

open Lwt.Syntax

let lre = "\xE2\x80\xAA"
let rle = "\xE2\x80\xAB"
let pdf = "\xE2\x80\xAC"

let strip_bidi s =
  let s =
    if String.length s >= 3 &&
       (String.sub s 0 3 = lre || String.sub s 0 3 = rle)
    then String.sub s 3 (String.length s - 3)
    else s
  in
  let s = String.trim s in
  let n = String.length s in
  if n >= 3 && String.sub s (n - 3) 3 = pdf
  then String.sub s 0 (n - 3)
  else s

type raw_line =
  | Label of string
  | Text  of string
  | Blank

let parse_raw_line raw =
  let s = strip_bidi raw in
  if String.length s = 0 then Blank
  else if String.length s >= 4 && String.sub s 0 4 = "xxxx" then
    Label (String.trim (String.sub s 4 (String.length s - 4)))
  else
    Text s

let extract_chapter label =
  try Scanf.sscanf label "Chapter %d" (fun c -> Some c)
  with _ -> None

type verse = {
  chapter    : int;
  verse      : int;
  accents    : string;
  consonants : string;
}

let parse_response text =
  String.split_on_char '\n' text
  |> List.map (fun line -> parse_raw_line (String.trim line))

let fetch ?(content="Accents") ?(layout="Full") citation =
  let uri =
    Printf.sprintf
      "https://tanach.us/Server.txt?%s&content=%s&layout=%s"
      citation content layout
    |> Uri.of_string
  in
  let* _resp, body = Cohttp_lwt_unix.Client.get uri in
  let* body_str = Cohttp_lwt.Body.to_string body in
  Lwt.return body_str

(* Zip two parsed line lists directly into verses,
   sharing chapter/verse state since structure is identical *)
let build_verses acc_lines con_lines =
  let chapter = ref 0 in
  let verse_num = ref 0 in
  let rec go = function
    | [], [] -> []
    | Label l :: ar, Label _ :: cr ->
        (match extract_chapter l with
         | Some c -> chapter := c; verse_num := 0
         | None   -> ());
        go (ar, cr)
    | Text acc :: ar, Text con :: cr ->
        incr verse_num;
        let v = { chapter = !chapter; verse = !verse_num;
                  accents = acc; consonants = con } in
        v :: go (ar, cr)
    | Blank :: ar, Blank :: cr -> go (ar, cr)
    | _ -> failwith "build_verses: mismatched structure between fetches"
    in
  go (acc_lines, con_lines)

let fetch_both citation =
  let* acc_text = fetch ~content:"Accents"    citation in
  let* con_text = fetch ~content:"Consonants" citation in
  let verses = build_verses
    (parse_response acc_text)
    (parse_response con_text)
  in
  Lwt.return verses

let () =
  let verses = Lwt_main.run (fetch_both "Genesis1:1-10") in
  List.iter (fun v ->
    Printf.printf "%d:%d\n  accents:    %s\n  consonants: %s\n"
      v.chapter v.verse v.accents v.consonants
  ) verses
