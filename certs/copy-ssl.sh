#!/bin/bash

script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd );
cd $script_dir;

source $script_dir/../../elastic-cluster/vars.sh

for index in "${!ips[@]}"
do
    run=$(($index + 1))

    ssh -i ~/.ssh/$sshkey -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@node"$run".evermight.net "mkdir /etc/elasticsearch/certs/node$run.evermight.net";
    scp -i ~/.ssh/$sshkey -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null node"$run".evermight.net/* root@node"$run".evermight.net:/etc/elasticsearch/certs/node$run.evermight.net;
    ssh -i ~/.ssh/$sshkey -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@node"$run".evermight.net "mkdir /etc/elasticsearch/certs/ca";
    scp -i ~/.ssh/$sshkey -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ca/root.crt root@node"$run".evermight.net:/etc/elasticsearch/certs/ca/;

    ssh -i ~/.ssh/$sshkey -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@node"$run".evermight.net "chown -R elasticsearch:elasticsearch /etc/elasticsearch/certs";
done
