
----

### [GET] /api/v1/roles

Get role list.

#
### Parameters
* project_id Integer - Project id
* account_id Integer - Account id


#### Response

Correct Response: 200 OK

```javascript


[
  {
    "id": 1638,
    "project_id": 791,
    "name": "administrator",
    "description": null,
    "created_at": "2016-03-25T07:05:00.101Z",
    "updated_at": "2016-03-25T07:05:00.101Z",
    "preset": true
  },
  {
    "id": 1639,
    "project_id": 791,
    "name": "operator",
    "description": null,
    "created_at": "2016-03-25T07:05:00.176Z",
    "updated_at": "2016-03-25T07:05:00.176Z",
    "preset": true
  },
  {
    "id": 1640,
    "project_id": 791,
    "name": "role_3",
    "description": "Role Description",
    "created_at": "2016-03-25T07:05:00.248Z",
    "updated_at": "2016-03-25T07:05:00.248Z",
    "preset": false
  },
  {
    "id": 1641,
    "project_id": 792,
    "name": "administrator",
    "description": null,
    "created_at": "2016-03-25T07:05:00.493Z",
    "updated_at": "2016-03-25T07:05:00.493Z",
    "preset": true
  },
  {
    "id": 1642,
    "project_id": 792,
    "name": "operator",
    "description": null,
    "created_at": "2016-03-25T07:05:00.566Z",
    "updated_at": "2016-03-25T07:05:00.566Z",
    "preset": true
  }
]
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [GET] /api/v1/roles/:id

Get specified role information.

#
### Parameters
* id Integer (required) - Role id


#### Response

Correct Response: 200 OK

```javascript


{
  "id": 1769,
  "project_id": 842,
  "name": "role_30",
  "description": "Role Description",
  "created_at": "2016-03-25T07:05:16.678Z",
  "updated_at": "2016-03-25T07:05:16.678Z",
  "preset": false
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [POST] /api/v1/roles

Create role.

#
### Parameters
* project_id Integer (required) - Project id
* name String (required) - Role name
* description String - Role description


#### Response

Correct Response: 201 Created

```javascript


{
  "id": 1788,
  "project_id": 848,
  "name": "role_39",
  "description": "Role Description",
  "created_at": "2016-03-25T07:05:19.342Z",
  "updated_at": "2016-03-25T07:05:19.342Z",
  "preset": false
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [PUT] /api/v1/roles/:id

Update role information.

#
### Parameters
* id Integer (required) - Role id
* name String - Role name
* description String - Role description


#### Response

Correct Response: 200 OK

```javascript


{
  "id": 1821,
  "project_id": 858,
  "name": "new_name",
  "description": "new_description",
  "created_at": "2016-03-25T07:05:23.293Z",
  "updated_at": "2016-03-25T07:05:23.425Z",
  "preset": false
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [DELETE] /api/v1/roles/:id

Delete role.

#
### Parameters
* id Integer (required) - Role id


#### Response

Correct Response: 204 No Content

```javascript

```

Error Response:

- Authentication failed: 401 Unauthorized
