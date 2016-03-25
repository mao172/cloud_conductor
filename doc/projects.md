
----

### [GET] /api/v1/projects

Get project list.

#

#### Response

Correct Response: 200 OK

```javascript


[
  {
    "id": 731,
    "name": "project_3",
    "description": "Project Description",
    "created_at": "2016-03-25T07:04:43.066Z",
    "updated_at": "2016-03-25T07:04:43.066Z"
  }
]
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [GET] /api/v1/projects/:id

Get specified project information.

#
### Parameters
* id Integer (required) - Project id


#### Response

Correct Response: 200 OK

```javascript


{
  "id": 738,
  "name": "project_10",
  "description": "Project Description",
  "created_at": "2016-03-25T07:04:45.467Z",
  "updated_at": "2016-03-25T07:04:45.467Z"
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [POST] /api/v1/projects

Create project.

#
### Parameters
* name String (required) - Project name
* description String - Project description


#### Response

Correct Response: 201 Created

```javascript


{
  "id": 748,
  "name": "project_21",
  "description": "Project Description",
  "created_at": "2016-03-25T07:04:48.634Z",
  "updated_at": "2016-03-25T07:04:48.634Z"
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [PUT] /api/v1/projects/:id

Update project information.

#
### Parameters
* id Integer (required) - Project id
* name String - Project name
* description String - Project description


#### Response

Correct Response: 200 OK

```javascript


{
  "id": 764,
  "name": "new_name",
  "description": "new_description",
  "created_at": "2016-03-25T07:04:53.537Z",
  "updated_at": "2016-03-25T07:04:53.677Z"
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [DELETE] /api/v1/projects/:id

Delete project.

#
### Parameters
* id Integer (required) - Project id


#### Response

Correct Response: 204 No Content

```javascript

```

Error Response:

- Authentication failed: 401 Unauthorized
