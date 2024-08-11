# Notes
Notes for the ILM Hot Warm Cold Playlist:

https://www.youtube.com/playlist?list=PLPatHYWw1RVsZjrBbP0bGMteyGK2Vf6HB

## Setup

The `elasticsearch.yml` files used were as follows:

1. `node-1.yml` was used on `node1.evermight.net` as the `/etc/elasticsearch/elasticsearch.yml` file.
2. `node-2.yml` was used on `node2.evermight.net` as the `/etc/elasticsearch/elasticsearch.yml` file.
3. `node-3.yml` was used on `node3.evermight.net` as the `/etc/elasticsearch/elasticsearch.yml` file.

The certs used were as follows:

1. `certs/node1.evermight.net/*` were copied to `node1.evermight.net` as `/etc/elasticsearch/certs/node1.evermight.net`.
2. `certs/node2.evermight.net/*` were copied to `node2.evermight.net` as `/etc/elasticsearch/certs/node2.evermight.net`.
3. `certs/node3.evermight.net/*` were copied to `node3.evermight.net` as `/etc/elasticsearch/certs/node3.evermight.net`.
4. `certs/ca/root.crt` was copied to `node1.evermight.net`, `node2.evermight.net` and `node3.evermight.net` as `/etc/elasticsearch/certs/ca/root.crt`.


