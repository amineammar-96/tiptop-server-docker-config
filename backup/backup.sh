export BORG_PASSPHRASE='F2i2023@grp2'

# docker folder backup
backup_directory="/backup/docker"
backup_name="docker"
/usr/bin/borg create $backup_directory::$backup_name ~/docker


backup_mysql_databases() {
    local container_name="$1"
    local backup_directory="$2"

    mkdir -p "$backup_directory/mysql"

    databases=$(docker exec "$container_name" sh -c 'mysql -sN -e "show databases;"')

    for db_name in $databases; do
        docker exec "$container_name" sh -c "mysqldump -u root  $db_name > /var/lib/mysql/$db_name.sql"
        docker cp "$container_name":/var/lib/mysql/$db_name.sql "$backup_directory/mysql/"
    done

}


#Dabases backups
backup_mysql_databases "docker-db-1" "/backup/databases/prod/"
backup_mysql_databases "docker-db_test-1" "/backup/databases/test/"

backup_container() {
    local container_name="$1"
    local backup_directory="$2"

    mkdir -p "$backup_directory/$container_name"

    docker exec "$container_name" sh -c "tar -czf - /" > "$backup_directory/$container_name/$container_name_backup.tar.gz"

    /usr/bin/borg create /backup::$backup_name "$backup_directory/$container_name"

    echo "Backup for container $container_name completed."
}

#backup docker containers
backup_container "docker-frontend-1" "/backup/containers"
backup_container "docker-frontend-dev-1" "/backup/containers"
backup_container "docker-backend-dev-1" "/backup/containers"
backup_container "docker-backend-1" "/backup/containers"
backup_container "docker-backend-preprod-1" "/backup/containers"
backup_container "docker-frontend-staging-1" "/backup/containers"
backup_container "docker-backend-staging-1" "/backup/containers"
backup_container "docker-frontend-preprod-1" "/backup/containers"
backup_container "docker-gateway-1" "/backup/containers"
backup_container "docker-sonarqube-1" "/backup/containers"
backup_container "docker-sonarqube-db-1" "/backup/containers"
backup_container "docker-prometheus-1" "/backup/containers"
backup_container "docker-grafana-1" "/backup/containers"
backup_container "docker-portainer-1" "/backup/containers"
backup_container "docker-alertmanager-1" "/backup/containers"

