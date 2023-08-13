FROM ubuntu:22.04 as python_base
ARG version
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Set the locale
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo tzdata \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME\
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && rm -rf /var/lib/apt/lists/* 

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    && apt-get -y clean && rm -rf /var/lib/apt/lists/*

ENV PATH=${PATH}:/home/user/.local/bin

# ###################      deploy     #############################

FROM python_base as deploy
RUN apt-get update && apt-get install -y \
    tk \
    python3-tk \
    && apt-get -y clean && rm -rf /var/lib/apt/lists/*

# WORKDIR /home/user
COPY ./requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /tmp/requirements.txt

# ###################      production     #############################

FROM deploy as prod
ARG APP_VER=0
USER user
WORKDIR /home/user
RUN echo ${APP_VER}
COPY ./dist/py_gui_demo-${APP_VER}-py3-none-any.whl /tmp
RUN pip install /tmp/py_gui_demo-${APP_VER}-py3-none-any.whl
ENTRYPOINT ["my_app"]

# ###################      development     #############################

FROM deploy as development

RUN apt-get update && apt-get install -y \
    git \
    python3-all \
    debhelper \
    dh-python \
    python3-stdeb \
    locales \
    locales-all \
    && apt-get -y clean && rm -rf /var/lib/apt/lists/*

COPY ./requirements-dev.txt /tmp/requirements-dev.txt
RUN pip install --no-cache-dir --upgrade -r /tmp/requirements-dev.txt

RUN echo $version > /tmp/version