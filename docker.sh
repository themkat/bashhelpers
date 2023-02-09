#!/bin/bash

# Deletes all temporary images created during builds ("none images")
function docker_delete_none_images() {
	for img in $(docker images -f dangling=true -q); do
		docker image rm "$img";
	done
}

# stops and removes all containers
# useful when we have made something with docker-compose in another directory and forgot about it.
# (that is the reason for also pruning networks)
function docker_stop_kill() {
    CONTAINERS=$(docker ps -q -a)

    if [ -z "$CONTAINERS" ];
    then
        echo "Can't stop and kill containers if there are none stupid :)"
        return 1
    fi

    docker container rm -f "$CONTAINERS"
    docker network prune -f
    unset CONTAINERS
}

# clears containers, builder cache, networks etc.
# data related to runtime operations
function docker_clear_runtime() {
    docker container prune -f
    docker builder prune -f --all
    docker network prune -f
    docker_delete_none_images
}
