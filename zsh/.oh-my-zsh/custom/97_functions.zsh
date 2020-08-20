
qsubcall(){
  qsub -N "aran" -M "aran@nordicsemi.no" -cwd -V -j y -o qsublog_\$JOB_ID.log -b y -S /bin/sh $*
  
}
qrsubcall(){
  qrsh -N "aran" -now no -pty yes -cwd -V $*
}

path_cleanup() {
  # Splits path entries into an array, using ':' as a delimiter
  path_original=("${(@s/:/)1}")
  path_clean=()

  for path_slice in $path_original; do
    # ${path_clean[]} <= array access
    # (ie) <= Subscript flags
    #   i <= reverse access (query for index from value)
    #   e <= exactmatch
    if [[ ${path_clean[(ie)$path_slice]} -gt ${#path_clean} ]]; then
      path_clean+=($path_slice)
    fi
  done

  # Joins the path_clean array with ':' as a delimiter
  echo ${(j[:])path_clean}
}

