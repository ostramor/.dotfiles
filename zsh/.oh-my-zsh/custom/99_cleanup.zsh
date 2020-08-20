#############################################################
# Setting user bin and lib paths as late as possible 
#############################################################

export PATH=$HOME/local/bin:$PATH
export LD_LIBRARY_PATH=$HOME/local/lib:$LD_LIBRARY_PATH
export LIBRARY_PATH=$HOME/local/lib:$LIBRARY_PATH
export CPATH=$HOME/local/include:$CPATH

#############################################################
# Cleaning repeated paths entries
#############################################################

export PATH=$(path_cleanup $PATH)
export LD_LIBRARY_PATH=$(path_cleanup $LD_LIBRARY_PATH)
export LIBRARY_PATH=$(path_cleanup $LIBRARY_PATH)
export CPATH=$(path_cleanup $CPATH)

#############################################################
