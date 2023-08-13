#!/bin/bash

docker run -it --rm \
    --name py_deploy \
    --hostname deploy \
    -u=$(id -u $USER):$(id -g $USER) \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v $(pwd)/dist:/dist \
    py_gui_demo:deploy \
    /bin/bash
