docker-rm-stopped-containers() {
    containers=$(docker ps -f status=exited -q)
    if [[ $containers != "" ]]; then
        echo "Deleting..."
        docker rm $containers
    else
        echo "Nothing to delete"
    fi
}
