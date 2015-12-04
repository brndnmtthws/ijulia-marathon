# IJulia Notebook on Marathon

Run it with this:

```json
{
  "id": "ijulia-notebook",
  "cmd":"run-ijulia-notebook",
  "cpus": 4,
  "mem": 4000,
  "ports":[10000],
  "instances": 1,
  "container": {
    "type": "DOCKER",
    "docker": {
      "image": "brndnmtthws/ijulia-notebook",
      "network": "HOST",
      "forcePullImage": true
    }
  },
  "healthChecks": [{
      "protocol": "HTTP",
      "path": "/",
      "portIndex": 0,
      "timeoutSeconds": 10,
      "gracePeriodSeconds": 10,
      "intervalSeconds": 2,
      "maxConsecutiveFailures": 10
  }],
  "labels":{
    "HAPROXY_GROUP":"external"
  }
}
```

Enjoy your time!
