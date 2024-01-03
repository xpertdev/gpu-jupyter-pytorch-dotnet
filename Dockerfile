FROM tensorflow/tensorflow:latest-gpu-jupyter

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York
ENV DOTNET_VERSION=8.0

RUN apt-get -y install wget \
    && wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install sudo nano python3 python3-pip python3-dev ipython3 plantuml libfontconfig1 nmap dotnet-sdk-$DOTNET_VERSION \
    && cp /usr/share/plantuml/plantuml.jar /usr/local/bin/plantuml.jar \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf packages-microsoft-prod.deb

RUN pip3 install --upgrade jupyterlab iplantuml graphviz matplotlib ipykernel

#RUN curl -sL https://deb.nodesource.com/setup_20.x | bash

# RUN apt install nodejs \
#     && pip3 install --upgrade jupyterlab-git \
#     && jupyter lab build

ARG NB_USER="jupyter"
ARG NB_UID="1000"
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
