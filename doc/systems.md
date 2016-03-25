
----

### [GET] /api/v1/systems

Get system list.

#
### Parameters
* project_id Integer - Project id


#### Response

Correct Response: 200 OK

```javascript


[
  {
    "id": 221,
    "project_id": 885,
    "primary_environment_id": null,
    "name": "system-3",
    "description": "sample system",
    "domain": "example.com",
    "created_at": "2016-03-25T07:05:36.398Z",
    "updated_at": "2016-03-25T07:05:36.398Z"
  }
]
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [GET] /api/v1/systems/:id

Get specified system information.

#
### Parameters
* id Integer (required) - System id


#### Response

Correct Response: 200 OK

```javascript


{
  "id": 238,
  "project_id": 902,
  "primary_environment_id": null,
  "name": "system-20",
  "description": "sample system",
  "domain": "example.com",
  "created_at": "2016-03-25T07:05:41.025Z",
  "updated_at": "2016-03-25T07:05:41.025Z"
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [POST] /api/v1/systems

Create system.

#
### Parameters
* project_id Integer (required) - Project id
* name String (required) - System name
* description String - System description
* domain String - System domain name


#### Response

Correct Response: 201 Created

```javascript


{
  "id": 245,
  "project_id": 908,
  "primary_environment_id": null,
  "name": "system-29",
  "description": "sample system",
  "domain": "example.com",
  "created_at": "2016-03-25T07:05:43.064Z",
  "updated_at": "2016-03-25T07:05:43.064Z"
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [PUT] /api/v1/systems/:id

Update system information.

#
### Parameters
* id Integer (required) - System id
* name String - System name
* description String - System description
* domain String - System domain name


#### Response

Correct Response: 200 OK

```javascript


{
  "id": 266,
  "project_id": 923,
  "primary_environment_id": null,
  "name": "new_name",
  "description": "sample system",
  "domain": "new.example.com",
  "created_at": "2016-03-25T07:05:48.031Z",
  "updated_at": "2016-03-25T07:05:48.066Z"
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [DELETE] /api/v1/systems/:id

Delete system.

#
### Parameters
* id Integer (required) - System id


#### Response

Correct Response: 204 No Content

```javascript

```

Error Response:

- Authentication failed: 401 Unauthorized
