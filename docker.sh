#!/bin/bash

# Deletes all temporary images created during builds ("none images")
function docker_delete_none_images() {
	for img in `docker images -f dangling=true -q`; do
		docker image rm $img;
	done
}

# clears containers, builder cache, networks etc.
# data related to runtime operations
function docker_clear_runtime() {
    docker container prune -f
    docker builder prune -f
    docker network prune -f
    docker_delete_none_images
}
