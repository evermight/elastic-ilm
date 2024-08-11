# Part 1: ILM Shard Allocation
Commands used in https://www.youtube.com/watch?v=TsDS-PtP2AE


```
GET /_cat/nodes

PUT /demo-000001
{
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
      "index.number_of_shards": 1
    }
}

GET /_cat/shards/demo-000001
GET /demo-000001/_search

POST /demo-000001/_doc
{
  "user": "john_doe",
  "message": "My test",
  "created_at": "2024-08-04T10:00:00Z"
}

PUT /demo-000001/_settings
{
  "index.routing.allocation.include._name": null
}

PUT /demo-000001/_settings
{
  "index.routing.allocation.include.my_identifier": "beta"
}

PUT /demo-000002
{
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
      "index.number_of_shards": 1
    }
}

GET /_cat/shards/demo-000002

POST /demo-000002/_doc
{
  "user": "john_doe",
  "message": "My second record",
  "created_at": "2024-08-04T10:00:00Z"
}

GET /demo/_search
GET /demo-000002/_search



POST _aliases
{
  "actions": [
    {
      "add": {
        "index": "demo-*",
        "alias": "demo"
      }
    },
    {
      "add": {
        "index": "demo-000002",
        "alias": "demo",
        "is_write_index": true
      }
    }
  ]
}

POST /demo/_doc
{
  "user": "john_doe",
  "message": "My fifth record",
  "created_at": "2024-08-04T10:00:00Z"
}


PUT /demo-000003
{
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
      "index.number_of_shards": 1
    }
}

GET _alias

POST _aliases
{
  "actions": [
    {
      "add": {
        "index": "demo-000002",
        "alias": "demo"
      }
    }
  ]
}
POST _aliases
{
  "actions": [
    {
      "add": {
        "index": "demo-000003",
        "alias": "demo",
        "is_write_index": true
      }
    }
  ]
}


DELETE /demo-000001
DELETE /demo-000002
DELETE /demo-000003
POST _aliases
{
  "actions": [
    {
      "remove": {
        "index": "demo-000003",
        "alias": "demo"
      }
    }
  ]
}

```

