#!/bin/bash

if [[ ! -z "${JUPYTER_PASSWORD_HASH}" ]]; then
  jupyter lab --NotebookApp.token='' --NotebookApp.password=${JUPYTER_PASSWORD_HASH} --NotebookApp.allow_origin='https://colab.research.google.com'
elif [[ "${JUPYTER_NO_PASSWORD}" == "true" ]]; then
  jupyter lab --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='https://colab.research.google.com'
else
  jupyter lab --NotebookApp.token='' --NotebookApp.allow_origin='https://colab.research.google.com'
fi