# Part 2: ILM Hot Warm Cold - Allocation
Commands used in https://www.youtube.com/watch?v=eOrI-Z0Nl1k

```

PUT /_ilm/policy/hot-warm-cold-policy
{
  "policy": {
    "phases": {
      "hot": {
        "min_age": "0ms",
        "actions": {
          "rollover": {
            "max_age": "5m"
          }
        }
      },
      "warm": {
        "min_age": "5m",
        "actions": {
          "allocate": {
            "require": {
              "my_identifier": "beta"
            },
            "number_of_replicas": 0
          },
          "forcemerge": {
            "max_num_segments": 1
          },
          "set_priority": {
            "priority": 50
          }
        }
      },
      "cold": {
        "min_age": "10m",
        "actions": {
          "allocate": {
            "require": {
              "my_identifier": "delta"
            },
            "number_of_replicas": 0
          },
          "set_priority": {
            "priority": 0
          }
        }
      },
      "delete": {
        "min_age": "15m",
        "actions": {
          "delete": {}
        }
      }
    }
  }
}

PUT /_index_template/template
{
  "index_patterns": ["demo-*"],
  "template": {
    "mappings": {
      "properties": {
        "@timestamp": {
          "type": "date"
        },
        "user": {
          "type": "keyword"
        },
        "message": {
          "type": "text"
        }
      }
    },
    "settings": {
      "index.routing.allocation.require.my_identifier": "alpha",
      "index.number_of_replicas": 0,
      "index.number_of_shards": 1,
      "index.lifecycle.name": "hot-warm-cold-policy",
      "index.lifecycle.rollover_alias": "demo-alias"
    }
  }
}


PUT /demo-000001
{
  "aliases": {
    "demo-alias": {
      "is_write_index": true
    }
  }
}



GET /_cat/shards/demo-000001

POST /demo-alias/_doc
{
  "user": "john_doe",
  "message": "My 6 Test",
  "created_at": "2024-08-04T10:00:00Z"
}

GET /demo-alias/_search
{
  "size":1000
}


GET /demo-alias/_ilm/explain

GET /_cat/indices

DELETE /demo-000005
DELETE /demo-000004
DELETE /demo-000003
DELETE /demo-000002
DELETE /demo-000001
DELETE /_index_template/template
DELETE /_ilm/policy/hot-warm-cold-policy

```
