let read_all filename =
  let channel = open_in filename in
  let data = really_input_string channel (in_channel_length channel) in
  close_in channel;
  data

let write_all ~name content =
  let channel = open_out name in
  output_string channel content;
  close_out_noerr channel

let () =
  let input_content = read_all Sys.argv.(1) in
  let output_content =
    Str.global_replace (Str.regexp {|\$(\([A-Za-z0-9]*\))|}) "${\\1}" input_content
  in
  write_all ~name:"python-config-fixed.sh" output_content
