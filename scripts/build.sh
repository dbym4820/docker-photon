#!/bin/sh

CDP=$(dirname $0)

docker build -t tomabu/photon $CDP/../
