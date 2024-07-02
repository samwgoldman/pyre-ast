let extract_flags script =
  let in_channel = Unix.open_process_args_in "/bin/sh" [| "/bin/sh"; script; "--libs" |] in
  let line = input_line in_channel |> String.trim in
  let _ = Unix.close_process_in in_channel in
  String.split_on_char ' ' line |> List.filter (fun word -> String.length word > 0)

let write_file ~name flags =
  let out_channel = open_out name in
  let output_content = Format.sprintf "(%s)\n" (String.concat " " flags) in
  output_string out_channel output_content;
  close_out_noerr out_channel

let () =
  let flags = extract_flags Sys.argv.(1) in
  write_file ~name:"ldflags.sexp" flags
