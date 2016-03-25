
----

### [GET] /api/v1/base_images

Get base_image list.

#
### Parameters
- cloud_id: Cloud id
- project_id: Project id


#### Response

Correct Response: 200 OK

```javascript


[
  {
    "id": 25,
    "cloud_id": 13,
    "source_image": "ami-76131818",
    "ssh_username": "centos",
    "created_at": "2016-03-25T07:01:58.675Z",
    "updated_at": "2016-03-25T07:01:58.675Z",
    "platform": "centos",
    "platform_version": "6.7"
  },
  {
    "id": 26,
    "cloud_id": 13,
    "source_image": "ami-b18c82df",
    "ssh_username": "centos",
    "created_at": "2016-03-25T07:01:58.683Z",
    "updated_at": "2016-03-25T07:01:58.683Z",
    "platform": "centos",
    "platform_version": "7.2"
  }
]
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [GET] /api/v1/base_images/:id

Get specified base_image information.

#
### Parameters
- *id: BaseImage id


#### Response

Correct Response: 200 OK

```javascript


{
  "id": 79,
  "cloud_id": 40,
  "source_image": "ami-76131818",
  "ssh_username": "centos",
  "created_at": "2016-03-25T07:02:06.653Z",
  "updated_at": "2016-03-25T07:02:06.653Z",
  "platform": "centos",
  "platform_version": "6.7"
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [POST] /api/v1/base_images

Register base_image.

#
### Parameters
- *cloud_id: Cloud id
- *ssh_username: SSH login username to created instance
- *source_image: AMI id on AWS or image UUID on openstack
- *platform: Operating system name
- platform_version: Operating system version


#### Response

Correct Response: 201 Created

```javascript


{
  "id": 93,
  "cloud_id": 46,
  "source_image": "ebd928f2-6279-4eee-a2f2-df19d297c657",
  "ssh_username": "centos",
  "created_at": "2016-03-25T07:02:09.157Z",
  "updated_at": "2016-03-25T07:02:09.157Z",
  "platform": "centos",
  "platform_version": "6.5"
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [PUT] /api/v1/base_images/:id

Update base_image information.

#
### Parameters
- *id: BaseImage id
- ssh_username: SSH login username to created instance
- source_image: AMI id on AWS or image UUID on openstack
- platform: Operating system name
- platform_version: Operating system version


#### Response

Correct Response: 200 OK

```javascript


{
  "id": 128,
  "cloud_id": 61,
  "source_image": "b5ee4b86-6f6e-47fe-9c8e-d810d73eba8f",
  "ssh_username": "root",
  "created_at": "2016-03-25T07:02:12.828Z",
  "updated_at": "2016-03-25T07:02:12.877Z",
  "platform": "CentOS",
  "platform_version": "6.7"
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [DELETE] /api/v1/base_images/:id

Delete base_image.

#
### Parameters
- *id: BaseImage id


#### Response

Correct Response: 204 No Content

```javascript

```

Error Response:

- Authentication failed: 401 Unauthorized
