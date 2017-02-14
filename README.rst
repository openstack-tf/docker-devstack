docker build -t 192.168.1.105:5000/carapax/devstack:v1 .

docker push 192.168.1.105:5000/carapax/devstack:v1

docker run -dti --privileged=true --name=carapax-devstack-v1 -v /LOCAL_DIR/device:/opt/stack/devicedemo -v /LOCAL_DIR/logs:/opt/stack/logs 192.168.1.105:5000/carapax/devstack:v1

docker exec -ti carapax-devstack-v1 script -q -c "/bin/bash" /dev/null

$ vim devstack/lib/databases/mysql
...
function configure_database_mysql {
...
    # Start mysql-server
    if is_fedora || is_suse || is_ubuntu; then
        # service is not started by default
        start_service $mysql
    fi
...
    iniset -sudo $my_conf mysqld collation-server utf8_general_ci
    iniset -sudo $my_conf mysqld character-set-server utf8
...


when screen -r stack error, run:
    script /dev/null
