# Tensorflow with GPU, Jupyter & .Net 8.0 on Docker
GPU enabled Jupyter with Tensorflow, Keras, python, and dotnet. This project was inspired by the original [jupyter-dotnet](https://github.com/joshendriks/jupyter-dotnet "jupyter-dotnet")

## Run options

### Without parameters

`docker run -it --rm -p 8888:8888 acevpn/gpu-jupyter-tensorflow-dotnet:latest`

## Run with a volume

Windows:
`docker run -it --rm -v %cd%:/home/jupyter/work -p 8888:8888 acevpn/gpu-jupyter-tensorflow-dotnet:latest`

Linux or MacOS:
`docker run -it --rm -v $PWD:/home/jupyter/work -p 8888:8888 acevpn/gpu-jupyter-tensorflow-dotnet:latest`

## Authentication

### Different password
`docker run -it --env JUPYTER_PASSWORD_HASH=<somehash> -p 8888:8888 acevpn/gpu-jupyter-tensorflow-dotnet:latest`

### Without password without token
`docker run -it --env JUPYTER_NO_PASSWORD=true -p 8888:8888 acevpn/gpu-jupyter-tensorflow-dotnet:latest`

## GPU support

### Verify your nvidia-docker installation
`docker run --gpus all --rm nvidia/cuda nvidia-smi`

### Run with GPU
`docker run --gpus all -it --rm -p 8888:8888 acevpn/gpu-jupyter-tensorflow-dotnet:latest`

## Docker Compose
Customize docker-compose.yml as needed