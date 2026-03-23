function hv --description 'wrapper for haven: ap or ed'
  if not using haven
    echo "Error: haven is not installed" >&2
    return 1
  end

  switch $argv[1]
    case ap
      haven apply
    case ed
      if using zed
        zed $(haven source-path)
      else
        echo "Error: zed command not found" >&2
        return 1
      end
    case cd
      cd $(haven source-path)
   case note
      haven telemetry --note $argv[2]
   case bug
      haven telemetry --bug $argv[2]
   case action
      haven telemetry --action $argv[2]
   case question
      haven telemetry --question $argv[2]
    case '*'
      haven $argv
  end
end
