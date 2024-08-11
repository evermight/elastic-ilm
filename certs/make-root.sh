#!/bin/bash

script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd );
cd $script_dir;
mkdir ca;
cd ca;

openssl genrsa -out root.key 2048

openssl req -x509 -sha256 -nodes -key root.key \
-subj "/C=CA/ST=ON/O=HelloWorld/CN=root.example.com" -days 3650 -out root.crt

