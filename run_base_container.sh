#!/bin/bash

docker run -it --rm \
    --name py_base \
    --hostname base \
    -u=$(id -u $USER):$(id -g $USER) \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v $(pwd)/dist:/dist \
    -v $(pwd)/deb/build:/deb \
    py_gui_demo:base \
    /bin/bash
