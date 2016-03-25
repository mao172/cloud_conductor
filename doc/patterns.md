
----

### [GET] /api/v1/patterns

Get pattern list.

#
### Parameters
- project_id: Project id


#### Response

Correct Response: 200 OK

```javascript


[
  {
    "id": 46,
    "name": "platform_pattern-3",
    "type": "platform",
    "protocol": "git",
    "url": "https://example.com/cloudconductor-dev/sample_platform_pattern.git",
    "revision": "master",
    "created_at": "2016-03-25T07:04:14.425Z",
    "updated_at": "2016-03-25T07:04:14.425Z",
    "project_id": 643,
    "roles": null,
    "providers": null,
    "secret_key": null
  }
]
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [GET] /api/v1/patterns/:id

Get specified pattern information.

#
### Parameters
- *id: Pattern id


#### Response

Correct Response: 200 OK

```javascript


{
  "id": 58,
  "name": "platform_pattern-15",
  "type": "platform",
  "protocol": "git",
  "url": "https://example.com/cloudconductor-dev/sample_platform_pattern.git",
  "revision": "master",
  "created_at": "2016-03-25T07:04:18.414Z",
  "updated_at": "2016-03-25T07:04:18.414Z",
  "project_id": 655,
  "roles": null,
  "providers": null,
  "secret_key": null
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [POST] /api/v1/patterns

Register pattern.

#
### Parameters
- *project_id: Project id
- *url: URL of repository that contains pattern
- revision: revision of repository
- secret_key: secret_key for private repository


#### Response

Correct Response: 201 Created

```javascript


{
  "id": 65,
  "name": "platform_pattern-24",
  "type": "platform",
  "protocol": "git",
  "url": "https://example.com/cloudconductor-dev/sample_platform_pattern.git",
  "revision": "master",
  "created_at": "2016-03-25T07:04:20.236Z",
  "updated_at": "2016-03-25T07:04:20.236Z",
  "project_id": 661,
  "roles": "[\"web\",\"ap\",\"db\"]",
  "providers": null,
  "secret_key": null
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [PUT] /api/v1/patterns/:id

Update pattern information.

#
### Parameters
- *id: Pattern id
- url: URL of repository that contains pattern
- revision: revision of repository
- secret_key: secret_key for private repository


#### Response

Correct Response: 200 OK

```javascript


{
  "id": 86,
  "name": "platform_pattern-50",
  "type": "platform",
  "protocol": "git",
  "url": "https://example.com/cloudconductor-dev/sample_optional_pattern.git",
  "revision": "develop",
  "created_at": "2016-03-25T07:04:24.580Z",
  "updated_at": "2016-03-25T07:04:24.598Z",
  "project_id": 676,
  "roles": null,
  "providers": null,
  "secret_key": null
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [DELETE] /api/v1/patterns/:id

Delete pattern.

#
### Parameters
- *id: Pattern id


#### Response

Correct Response: 204 No Content

```javascript

```

Error Response:

- Authentication failed: 401 Unauthorized
