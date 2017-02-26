#!/usr/bin/env bash
#wget https://raw.githubusercontent.com/andmos/Docker-Atom/master/Dockerfile
docker build -t atom .
docker run -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY atom