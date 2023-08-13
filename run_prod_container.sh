#!/bin/bash

docker run --rm \
    --name py_prod \
    --hostname prod \
    -u=$(id -u $USER):$(id -g $USER) \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    py_gui_demo:prod
