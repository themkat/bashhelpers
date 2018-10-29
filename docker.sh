#!/bin/bash

# Deletes all temporary images created during builds ("none images")
function docker_delete_none_images() {
	for img in `docker images -f dangling=true -q`; do
		docker image rm $img;
	done
}

