
----

### [GET] /api/v1/clouds

Get cloud list.

#
### Parameters
- project_id: Project id


#### Response

Correct Response: 200 OK

```javascript


[
  {
    "id": 107,
    "project_id": 454,
    "name": "cloud_3",
    "description": "cloud description",
    "type": "aws",
    "entry_point": "ap-northeast-1",
    "key": "aws_access_key",
    "tenant_name": null,
    "created_at": "2016-03-25T07:03:07.497Z",
    "updated_at": "2016-03-25T07:03:07.497Z",
    "secret": "********"
  }
]
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [GET] /api/v1/clouds/:id

Get specified cloud information.

#
### Parameters
- *id: Cloud id


#### Response

Correct Response: 200 OK

```javascript


{
  "id": 124,
  "project_id": 471,
  "name": "cloud_20",
  "description": "cloud description",
  "type": "aws",
  "entry_point": "ap-northeast-1",
  "key": "aws_access_key",
  "tenant_name": null,
  "created_at": "2016-03-25T07:03:12.694Z",
  "updated_at": "2016-03-25T07:03:12.694Z",
  "secret": "********"
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [POST] /api/v1/clouds

Register cloud.

#
### Parameters
- *project_id: Project id
- *name: Cloud name
- *type: Cloud type (aws or openstack)
- *key: AccessKey or username to authenticate cloud
- secret: SecretKey or password to authenticate cloud
- *entry_point: Entry point (e.g. ap-northeast-1 or http://<your-openstack>:5000/)
- description: Cloud description
- tenant_name: Tenant name (OpenStack only)


#### Response

Correct Response: 201 Created

```javascript


{
  "id": 131,
  "project_id": 477,
  "name": "cloud_29",
  "description": "cloud description",
  "type": "openstack",
  "entry_point": "http://127.0.0.1:5000/v1",
  "key": "openstack username",
  "tenant_name": "openstack tenant name",
  "created_at": "2016-03-25T07:03:15.324Z",
  "updated_at": "2016-03-25T07:03:15.324Z",
  "secret": "********"
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [PUT] /api/v1/clouds/:id

Update cloud information.

#
### Parameters
- *id: Cloud id
- name: Cloud name
- type: Cloud type (aws or openstack)
- key: AccessKey or username to authenticate cloud
- secret: SecretKey or password to authenticate cloud
- entry_point: Entry point (e.g. ap-northeast-1 or http://<your-openstack>:5000/)
- description: Cloud description
- tenant_name: Tenant name (OpenStack only)


#### Response

Correct Response: 200 OK

```javascript


{
  "id": 152,
  "project_id": 492,
  "name": "new_openstack",
  "description": "cloud description",
  "type": "openstack",
  "entry_point": "http://127.0.0.1:5000/v1",
  "key": "new_key",
  "tenant_name": "demo",
  "created_at": "2016-03-25T07:03:20.818Z",
  "updated_at": "2016-03-25T07:03:20.894Z",
  "secret": "********"
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [DELETE] /api/v1/clouds/:id

Delete cloud.

#
### Parameters
- *id: Cloud id


#### Response

Correct Response: 204 No Content

```javascript

```

Error Response:

- Authentication failed: 401 Unauthorized
