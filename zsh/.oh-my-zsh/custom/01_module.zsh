
if [[ $HOSTNAME = *.nordicsemi.no ]]; then
  source /cad/gnu/modules/modules-tcl/init/zsh
  module purge &> /dev/null
  module use /cad/gnu/modules/modulefiles2.0
  module load common_setup
  module load misctools/anaconda/3-4.3.0
  module load misctools/git/2.6.2
  module load misctools/gcc/gcc6.3.0
  module load questasim/10.7c_3
  module load visualizer/10.7c_3
  module load gnutools/grid-engine
fi

