# Part 3: ILM Hot Warm Cold - Migration
Commands used in https://www.youtube.com/watch?v=JsCB_VoOrWc

```
GET /_cat/nodes

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

PUT /_index_template/demo_template
{
  "index_patterns": ["demo-*"],
  "template": {
    "settings": {
      "index.routing.allocation.include._tier_preference": "data_hot",
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

POST /demo-alias/_doc
{
  "user": "john_user",
  "message": "index message 10",
  "created_at": "2024-08-04T10:00:00Z"
}


GET /demo-alias/_search
{"size":1000}

GET /_cat/shards/demo-000001


GET /demo-alias/_ilm/explain


GET /_cat/indices

DELETE /demo-000007
DELETE /demo-000006
DELETE /demo-000005
DELETE /demo-000004
DELETE /demo-000003
DELETE /demo-000002
DELETE /demo-000001
DELETE /_index_template/template
DELETE /_ilm/policy/hot-warm-cold-policy


```
