# Part 4: ILM Hot Warm Cold - Data Streams
Commands used in https://www.youtube.com/watch?v=6bn1Ztaketc

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

DELETE _index_template/demo_template

PUT _index_template/template
{
  "index_patterns": ["demo*"],
  "data_stream": {},
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
      "index.number_of_replicas": 0,
      "index.number_of_shards": 1,
      "index.lifecycle.name": "hot-warm-cold-policy"
    }
  }
}

POST /demo/_doc
{
  "user": "john_doe",
  "message": "DS Document 5",
  "@timestamp": "2024-08-04T10:00:00Z"
}

GET /_cat/shards/.ds-demo-2024.08.11-000001

GET /demo/_ilm/explain

GET /demo/_search
{"size": 1000}

```
