# PyTorch with GPU, Jupyter & .Net 8.0 on Docker
GPU enabled Jupyter with PyTorch, Python, and dotnet.

## Running the Container

### Without the parameters

`docker run -it --rm -p 8888:8888 acevpn/gpu-jupyter-pytorch-dotnet:latest`

## Run with a volume

Windows:
`docker run -it --rm -v %cd%:/home/jovyan/work -p 8888:8888 acevpn/gpu-jupyter-pytorch-dotnet:latest`

Linux or MacOS:
`docker run -it --rm -v $PWD:/home/jovyan/work -p 8888:8888 acevpn/gpu-jupyter-pytorch-dotnet:latest`

## Additional Configuration
For more configuration options, refer to the [Jupyter Docker Stacks documentation](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/running.html).

## GPU support

### Verify your nvidia-docker installation
`docker run --gpus all --rm nvidia/cuda nvidia-smi`

### Run with GPU
`docker run --gpus all -it --rm -p 8888:8888 acevpn/gpu-jupyter-pytorch-dotnet:latest`

## Docker Compose
Customize docker-compose.yml as needed