NVARCH=`uname -s`_`uname -m`; export NVARCH
NVCOMPILERS=/opt/nvidia/hpc_sdk; export NVCOMPILERS
MANPATH=$MANPATH:$NVCOMPILERS/$NVARCH/21.7/compilers/man; export MANPATH
PATH=$NVCOMPILERS/$NVARCH/21.7/compilers/bin:$PATH; export PATH
