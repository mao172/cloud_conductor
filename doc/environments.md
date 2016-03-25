
----

### [GET] /api/v1/environments

Get environment list.

#
### Parameters
- system_id: System id
- project_id: Project id


#### Response

Correct Response: 200 OK

```javascript


[
  {
    "id": 13,
    "system_id": 113,
    "name": "environment-3",
    "description": "environment description",
    "status": "PENDING",
    "frontend_address": "127.0.0.1",
    "created_at": "2016-03-25T07:03:27.910Z",
    "updated_at": "2016-03-25T07:03:27.910Z",
    "blueprint_history_id": 47,
    "template_parameters": "{}",
    "consul_addresses": "127.0.0.1",
    "application_status": "NOT_DEPLOYED"
  }
]
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [GET] /api/v1/environments/:id

Get specified environment information.

#
### Parameters
- *id: Environment id


#### Response

Correct Response: 200 OK

```javascript


{
  "id": 40,
  "system_id": 140,
  "name": "environment-30",
  "description": "environment description",
  "status": "PENDING",
  "frontend_address": "127.0.0.1",
  "created_at": "2016-03-25T07:03:39.658Z",
  "updated_at": "2016-03-25T07:03:39.658Z",
  "blueprint_history_id": 74,
  "template_parameters": "{}",
  "consul_addresses": "127.0.0.1",
  "application_status": "NOT_DEPLOYED"
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [POST] /api/v1/environments

Create environment.

#
### Parameters
- *system_id: System id
- *blueprint_id: Blueprint id
- *version: Blueprint version
- *name: Environment name
- description: Environment description
- template_parameters: Variables to build environment by cfn/terraform
- user_attributes: User Attribute JSON
- *candidates_attributes: Cloud ids to build environment
 * cloud_id String (required) - Cloud id
 * priority Integer - Cloud priority(prefer cloud that has higher value)


#### Response

Correct Response: 202 Accepted

```javascript


{
  "id": 47,
  "system_id": 146,
  "name": "environment-39",
  "description": "environment description",
  "status": "PENDING",
  "frontend_address": null,
  "created_at": "2016-03-25T07:03:43.112Z",
  "updated_at": "2016-03-25T07:03:43.112Z",
  "blueprint_history_id": 80,
  "template_parameters": "{}",
  "consul_addresses": null,
  "application_status": "NOT_DEPLOYED"
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [PUT] /api/v1/environments/:id

Update environment information.

#
### Parameters
- *id: Environment id
- name: Environment name
- description: Environment description
- user_attributes: User Attributes JSON
- template_parameters: Variables to build environment by cfn/terraform


#### Response

Correct Response: 200 OK

```javascript


{
  "id": 78,
  "system_id": 171,
  "name": "new_name",
  "description": "new_description",
  "status": "PENDING",
  "frontend_address": "127.0.0.1",
  "created_at": "2016-03-25T07:03:56.719Z",
  "updated_at": "2016-03-25T07:03:56.745Z",
  "blueprint_history_id": 105,
  "template_parameters": "{}",
  "consul_addresses": "127.0.0.1",
  "application_status": "NOT_DEPLOYED"
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [DELETE] /api/v1/environments/:id

Delete environment.

#
### Parameters
- *id: Environment id


#### Response

Correct Response: 204 No Content

```javascript

```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [POST] /api/v1/environments/:id/rebuild

Rebuild environment.

#
### Parameters
- *id: Environment id
- name: Blueprint name
- blueprint_id: Blueprint id
- version: Blueprint version
- description: Environment description
- switch: Switch primary environment automatically
- template_parameters: Variables to build environment by cfn/terraform
- user_attributes: User Attributes JSON


#### Response

Correct Response: 202 Accepted

```javascript


{
  "id": 108,
  "system_id": 191,
  "name": "environment-114-916007a3-0ffe-4bca-b086-720cb3d60541",
  "description": "new_description",
  "status": "PENDING",
  "frontend_address": null,
  "created_at": "2016-03-25T07:04:04.060Z",
  "updated_at": "2016-03-25T07:04:04.060Z",
  "blueprint_history_id": 125,
  "template_parameters": "{}",
  "consul_addresses": null,
  "application_status": "NOT_DEPLOYED"
}
```

Error Response:

- Authentication failed: 401 Unauthorized
