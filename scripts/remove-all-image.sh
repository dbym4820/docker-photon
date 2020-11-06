#!/bin/sh

CDP=$(dirname $0)
sh $CDP/kill-all-container.sh
docker rmi tomabu/photon
