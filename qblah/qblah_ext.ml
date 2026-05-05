let books = [
    "Genesis"; "Exodus"; "Leviticus"; "Numbers"; "Deuteronomy";
    "Joshua"
  ]

let urlForBook b = "https://tanach.us/Books/" ^ b ^ ".xml"

let get_xml url =
  match Curly.get url with
  | Ok response -> 
      let body = response.Curly.Response.body in
      let (_, xml) = Ezxmlm.from_string body in
      xml
  | Error _ -> failwith "Failed to download"

let getBookNamed b = get_xml (urlForBook b)

(*********************************)

let print_genesis () =
  let x = getBookNamed "Genesis" in
  print_string (Ezxmlm.to_string x)
  
