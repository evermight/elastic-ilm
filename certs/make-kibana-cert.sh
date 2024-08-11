#!/bin/bash

script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd );
cd $script_dir;

mkdir kibana.evermight.net

cd kibana.evermight.net;

cp ../meta.cnf ./;

sed -i 's/##FQDN##/kibana.evermight.net/g' meta.cnf

openssl genrsa -out entity.key 2048

openssl req -new -sha256 -nodes -key entity.key -config meta.cnf -out entity.csr

openssl x509 -req -in entity.csr -CA ../ca/root.crt -CAkey ../ca/root.key \
  -CAcreateserial -out entity.crt -days 500 -sha256 -extensions v3_req \
  -extfile meta.cnf;

cat entity.crt ../ca/root.crt > entity.full.crt;
cd ../

