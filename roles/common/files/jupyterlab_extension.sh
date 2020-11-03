#!/usr/bin/env bash

__conda_setup="$($1 'shell.bash' 'hook' 2> /dev/null)"
eval "$__conda_setup"

conda activate $2 && \
  jupyter labextension install dask-labextension @ryantam626/jupyterlab_code_formatter && \
  jupyter serverextension enable dask_labextension && \
  jupyter serverextension enable --py jupyterlab_code_formatter
