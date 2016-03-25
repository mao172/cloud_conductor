
----

### [GET] /api/v1/blueprints

Get blueprint list.

#
### Parameters
- project_id: Project id


#### Response

Correct Response: 200 OK

```javascript


[
  {
    "id": 83,
    "project_id": 388,
    "name": "blueprint-3",
    "description": "blueprint description",
    "created_at": "2016-03-25T07:02:46.968Z",
    "updated_at": "2016-03-25T07:02:46.968Z"
  }
]
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [GET] /api/v1/blueprints/:id

Get specified blueprint information.

#
### Parameters
- *id: Blueprint id


#### Response

Correct Response: 200 OK

```javascript


{
  "id": 100,
  "project_id": 405,
  "name": "blueprint-20",
  "description": "blueprint description",
  "created_at": "2016-03-25T07:02:52.654Z",
  "updated_at": "2016-03-25T07:02:52.654Z"
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [POST] /api/v1/blueprints

Create blueprint.

#
### Parameters
- *project_id: Project id
- *name: Blueprint name
- description: Blueprint description


#### Response

Correct Response: 201 Created

```javascript


{
  "id": 107,
  "project_id": 411,
  "name": "blueprint-29",
  "description": "blueprint description",
  "created_at": "2016-03-25T07:02:54.821Z",
  "updated_at": "2016-03-25T07:02:54.821Z"
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [PUT] /api/v1/blueprints/:id

Update blueprint information.

#
### Parameters
- *id: Blueprint id
- name: Blueprint name
- description: Blueprint description


#### Response

Correct Response: 200 OK

```javascript


{
  "id": 128,
  "project_id": 426,
  "name": "new_name",
  "description": "new_description",
  "created_at": "2016-03-25T07:02:59.817Z",
  "updated_at": "2016-03-25T07:02:59.855Z"
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [DELETE] /api/v1/blueprints/:id

Delete base_image.

#
### Parameters
- *id: Blueprint id


#### Response

Correct Response: 204 No Content

```javascript

```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [POST] /api/v1/blueprints/:id/build

Build blueprint history with images from blueprint.

#
### Parameters
- *blueprint_id: Blueprint id


#### Response

Correct Response: 202 Accepted

```javascript


{
  "id": 38,
  "blueprint_id": 147,
  "version": 1,
  "consul_secret_key": "H2aGwO5orQZUyhyUMaFzGw==",
  "created_at": "2016-03-25T07:03:04.848Z",
  "updated_at": "2016-03-25T07:03:04.848Z",
  "encrypted_ssh_private_key": "********",
  "status": "CREATE_COMPLETE"
}
```

Error Response:

- Authentication failed: 401 Unauthorized
