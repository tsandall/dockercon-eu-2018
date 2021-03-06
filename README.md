# DockerCon EU 2018

This repository contains examples for DockerCon 2018.

## Examples

### Execute a query for a request that should be allowed.

```bash
opa eval -d example.rego \
    -d data.json \
    -i examples/allowed/input.json \
    'data.acmecorp.authz.allow'
```

**Example output**:

```json
{
  "result": [
    {
      "expressions": [
        {
          "value": true,
          "text": "data.acmecorp.authz.allow",
          "location": {
            "row": 1,
            "col": 1
          }
        }
      ]
    }
  ]
}

```

### Execute a query for a request that should be denied.

```bash
opa eval -d example.rego \
    -d data.json \
    -i examples/denied/input.json \
    'data.acmecorp.authz.allow'
```

**Example output**:

```json
{
  "result": [
    {
      "expressions": [
        {
          "value": false,
          "text": "data.acmecorp.authz.allow",
          "location": {
            "row": 1,
            "col": 1
          }
        }
      ]
    }
  ]
}
```

### Execute a query against a package.

```
opa eval -d . 'data.acmecorp.devices'
```

> This policy allows 'device update' operations to be executed between 10:00 and
> 15:00 GMT. Depending on when you run this, it'll return different answers!

**Example output**:

```json
{
  "result": [
    {
      "expressions": [
        {
          "value": {
            "allow": true,
            "input": {
              "action": "UpdateDevice",
              "subject": {
                "groups": [
                  "support"
                ]
              }
            },
            "inside_business_hours": true,
            "seconds_per_hour": 3600,
            "seconds_per_minute": 60
          },
          "text": "data.acmecorp.devices",
          "location": {
            "row": 1,
            "col": 1
          }
        }
      ]
    }
  ]
}
```

### Execute a Kubernetes admission control policy query.

```
opa eval -d . 'data.acmecorp.kubernetes.violation'
```

> This policy restricts which apps can use the 'retain' storage reclaim policy
> and ensures that all resources have an 'app' label.

**Example output**:

```json
{
  "result": [
    {
      "expressions": [
        {
          "value": [
            "pvc not whitelisted to use 'retain' reclaim policy"
          ],
          "text": "data.acmecorp.kubernetes.violation",
          "location": {
            "row": 1,
            "col": 1
          }
        }
      ]
    }
  ]
}
```
