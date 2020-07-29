function vimr {
  if [[ $# -gt 0 ]]; then
    if [ -d $1 ]; then # is a directory
      /usr/local/bin/vimr --cwd $1
    else
      /usr/local/bin/vimr --cwd $(pwd) $1
    fi
  else
      /usr/local/bin/vimr --cwd $(pwd)
  fi
}
