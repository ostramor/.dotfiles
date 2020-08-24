
export HOSTNAME=$(uname -n)
export PATH=$PATH:.:/usr/bin:/bin:/usr/X11R6/bin

if [[ $HOSTNAME = *.nordicsemi.no ]]; then
  export PATH=/pri/$USER/dogit:$PATH
fi

