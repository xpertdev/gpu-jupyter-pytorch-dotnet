FROM quay.io/jupyter/pytorch-notebook:cuda12-latest

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York
ENV DOTNET_VERSION=8.0

USER root

RUN apt-get update && apt-get -y upgrade \
    && apt-get -y install wget sudo nano python3 python3-pip python3-dev ipython3 libfontconfig1 \ 
    #&& cp /usr/share/plantuml/plantuml.jar /usr/local/bin/plantuml.jar \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin -Channel $DOTNET_VERSION -InstallDir /usr/share/dotnet \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
RUN pip3 install --upgrade jupyterlab matplotlib ipykernel

#RUN curl -sL https://deb.nodesource.com/setup_20.x | bash

# RUN apt install nodejs \
#     && pip3 install --upgrade jupyterlab-git \
#     && jupyter lab build

ARG NB_USER="jupyter"
ARG NB_UID="1001"
ARG NB_GID="100"

RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER

USER $NB_USER

ENV HOME=/home/$NB_USER
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
ENV DOTNET_INTERACTIVE_CLI_TELEMETRY_OPTOUT=1

WORKDIR $HOME

ENV PATH="${PATH}:$HOME/.dotnet/tools/"

RUN dotnet tool install --global Microsoft.dotnet-interactive

RUN dotnet interactive jupyter install
RUN jupyter kernelspec list

COPY ./jupyter_notebook_config.py $HOME/.jupyter/jupyter_notebook_config.py

RUN mkdir $HOME/work
RUN mkdir $HOME/work/examples
COPY csharp.ipynb $HOME/work/examples/csharp.ipynb
COPY plantuml.ipynb $HOME/work/examples/plantuml.ipynb
COPY graphviz.ipynb $HOME/work/examples/graphviz.ipynb

USER root

RUN chown -R jupyter $HOME/work/examples

RUN usermod -aG sudo $NB_USER

# prevent git init on this level
RUN mkdir $HOME/work/.git
COPY start.sh /start.sh
RUN chmod +x /start.sh
USER $NB_USER

CMD ["/start.sh"]
