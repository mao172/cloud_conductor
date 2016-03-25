
----

### [GET] /api/v1/applications

Get application list.

#
### Parameters
* system_id Integer - Target system id
* project_id Integer - Target project id


#### Response

Correct Response: 200 OK

```javascript


[
  {
    "id": 41,
    "system_id": 41,
    "name": "application_3",
    "description": "application description",
    "created_at": "2016-03-25T07:00:53.732Z",
    "updated_at": "2016-03-25T07:00:53.732Z",
    "domain": "app.example.com"
  }
]
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [GET] /api/v1/applications/:id

Get specified application information.

#
### Parameters
* id Integer (required) - Application id


#### Response

Correct Response: 200 OK

```javascript


{
  "id": 58,
  "system_id": 58,
  "name": "application_20",
  "description": "application description",
  "created_at": "2016-03-25T07:00:59.592Z",
  "updated_at": "2016-03-25T07:00:59.592Z",
  "domain": "app.example.com"
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [POST] /api/v1/applications

Create application.

#
### Parameters
* system_id Integer (required) - Target system id
* name String (required) - Application name
* description String - Application description
* domain String - Application domain name


#### Response

Correct Response: 201 Created

```javascript


{
  "id": 65,
  "system_id": 64,
  "name": "application_29",
  "description": "application description",
  "created_at": "2016-03-25T07:01:01.614Z",
  "updated_at": "2016-03-25T07:01:01.614Z",
  "domain": "app.example.com"
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [PUT] /api/v1/applications/:id

Update application information.

#
### Parameters
* id Integer (required) - Application id
* name String - Application name
* description String - Application description
* domain String - Application domain name


#### Response

Correct Response: 200 OK

```javascript


{
  "id": 86,
  "system_id": 79,
  "name": "new_name",
  "description": "application description",
  "created_at": "2016-03-25T07:01:06.286Z",
  "updated_at": "2016-03-25T07:01:06.325Z",
  "domain": "app.example.com"
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [DELETE] /api/v1/applications/:id

Delete application.

#
### Parameters
* id Integer (required) - Application id


#### Response

Correct Response: 204 No Content

```javascript

```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [POST] /api/v1/applications/:id/deploy

Deploy application to environment.

#
### Parameters
* id Integer (required) - Application id
* environment_id Integer (required) - Target environment id
* application_history_id Integer - Application history id


#### Response

Correct Response: 202 Accepted

```javascript


{
  "id": 1,
  "environment_id": 4,
  "application_history_id": 48,
  "status": "PENDING",
  "created_at": "2016-03-25T07:01:12.203Z",
  "updated_at": "2016-03-25T07:01:12.203Z"
}
```

Error Response:

- Authentication failed: 401 Unauthorized
