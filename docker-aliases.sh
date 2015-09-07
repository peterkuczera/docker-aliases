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
    docker exec -it $ID bash -c "export TERM=xterm; bash"
}

docker-list-container-ips() {
    printf "%-12s   %-15s   %s\n" "CONTAINER ID" "IP" "NAMES"
    for ID in $(docker ps -q); do
        NAMES=$(docker inspect --format '{{ .Name }}' $ID)
        IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $ID)
        printf "%-12s   %-15s   %s\n" $ID $IP $NAMES
    done
}
