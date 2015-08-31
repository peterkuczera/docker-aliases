docker-rm-stopped-containers() {
    containers=$(docker ps -f status=exited -q)
    if [[ $containers != "" ]]; then
        echo "Deleting..."
        docker rm $containers
    else
        echo "Nothing to delete"
    fi
}

docker-connect() {
    if [[ $1 == "" ]]; then
        echo "You must supply a container name"
        return
    fi

    NAME=$1
    ID=$(docker ps | grep $NAME | awk '{print $1}')
    docker exec -it $ID bash -c "export TERM=linux; bash"
}
