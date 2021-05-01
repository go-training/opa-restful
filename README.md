# opa-resful

[![Open Policy Agent Testing](https://github.com/go-training/opa-restful/actions/workflows/opa.yml/badge.svg)](https://github.com/go-training/opa-restful/actions/workflows/opa.yml)

## System Flow

![flow](./images/flow.png)

## Integrating with the REST API

This document is the authoritative specification of the [OPA REST API](https://www.openpolicyagent.org/docs/latest/rest-api/).

### Run Open Policy Server

Please execute the following command:

```sh
$ opa run --server
{"addrs":[":8181"],"diagnostic-addrs":[],"level":"info","msg":"Initializing server.","time":"2021-04-27T15:54:57+08:00"}
```

### Upload custom data

Uploading the role permission and group data:

```sh
curl -X PUT http://localhost:8181/v1/data/rbac/authz/acl --data-binary @data.json
```

See the data with `JSON` format:

[embedmd]:# (data.json)
```json
{
  "group_roles": {
    "admin": ["admin"],
    "quality_head_design": ["quality_head_design"],
    "quality_head_system": ["quality_head_system"],
    "quality_head_manufacture": ["quality_head_manufacture"],
    "kpi_editor_design": ["kpi_editor_design"],
    "kpi_editor_system": ["kpi_editor_system"],
    "kpi_editor_manufacture": ["kpi_editor_manufacture"],
    "viewer": ["viewer"],
    "viewer_limit_ds": ["viewer_limit_ds"],
    "viewer_limit_m": ["viewer_limit_m"],
    "design_group_kpi_editor": ["kpi_editor_design", "viewer_limit_ds"],
    "system_group_kpi_editor": ["kpi_editor_system", "viewer_limit_ds"],
    "manufacture_group_kpi_editor": ["kpi_editor_manufacture", "viewer"],
    "project_leader": ["viewer_limit_ds", "viewer_limit_m"]
  },
  "role_permissions": {
    "admin": [
      {"action": "view_all", "object": "design"},
      {"action": "edit", "object": "design"},
      {"action": "view_all", "object": "system"},
      {"action": "edit", "object": "system"},
      {"action": "view_all", "object": "manufacture"},
      {"action": "edit", "object": "manufacture"}
    ],
    "quality_head_design": [
      {"action": "view_all", "object": "design"},
      {"action": "edit", "object": "design"},
      {"action": "view_all", "object": "system"},
      {"action": "view_all", "object": "manufacture"}
    ],
    "quality_head_system": [
      {"action": "view_all", "object": "design"},
      {"action": "view_all", "object": "system"},
      {"action": "edit", "object": "system"},
      {"action": "view_all", "object": "manufacture"}
    ],
    "quality_head_manufacture": [
      {"action": "view_all", "object": "design"},
      {"action": "view_all", "object": "system"},
      {"action": "view_all", "object": "manufacture"},
      {"action": "edit", "object": "manufacture"}
    ],
    "kpi_editor_design": [
      {"action": "view_all", "object": "design"},
      {"action": "edit", "object": "design"}
    ],
    "kpi_editor_system": [
      {"action": "view_all", "object": "system"},
      {"action": "edit", "object": "system"}
    ],
    "kpi_editor_manufacture": [
      {"action": "view_all", "object": "manufacture"},
      {"action": "edit", "object": "manufacture"}
    ],
    "viewer": [
      {"action": "view_all", "object": "design"},
      {"action": "view_all", "object": "system"},
      {"action": "view_all", "object": "manufacture"}
    ],
    "viewer_limit_ds": [
      {"action": "view_all", "object": "design"},
      {"action": "view_all", "object": "system"}
    ],
    "viewer_limit_m": [{"action": "view_l3_project", "object": "manufacture"}]
  }
}
```

### Upload policy data

```sh
curl -X PUT http://localhost:8181/v1/policies/rbac.authz --data-binary @rbac.authz.rego
```

See the rego data

[embedmd]:# (rbac.authz.rego)
```rego
package rbac.authz

import data.rbac.authz.acl
import input

# logic that implements RBAC.
default allow = false

allow {
	# lookup the list of roles for the user
	roles := acl.group_roles[input.user[_]]

	# for each role in that list
	r := roles[_]

	# lookup the permissions list for role r
	permissions := acl.role_permissions[r]

	# for each permission
	p := permissions[_]

	# check if the permission granted to r matches the user's request
	p == {"action": input.action, "object": input.object}
}
```

### Testing your input

```sh
curl -X POST http://localhost:8181/v1/data/rbac/authz/allow --data-binary @input.json
```

See the input data with `JSON` format.

[embedmd]:# (input.json)
```json
{
  "input": {
    "user": ["design_group_kpi_editor", "system_group_kpi_editor"],
    "action": "edit",
    "object": "design"
  }
}
```
