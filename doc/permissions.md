
## GET /roles/:role_id/permissions/

Get permission list.


### Response

Correct Response: 200 OK

```


[
  {
    "id": 139,
    "role_id": 9,
    "model": "account",
    "action": "read",
    "created_at": "2016-03-25T05:09:27.603Z",
    "updated_at": "2016-03-25T05:09:27.603Z"
  },
  {
    "id": 134,
    "role_id": 9,
    "model": "application",
    "action": "manage",
    "created_at": "2016-03-25T05:09:27.543Z",
    "updated_at": "2016-03-25T05:09:27.543Z"
  },
  {
    "id": 135,
    "role_id": 9,
    "model": "application_history",
    "action": "manage",
    "created_at": "2016-03-25T05:09:27.555Z",
    "updated_at": "2016-03-25T05:09:27.555Z"
  },
  {
    "id": 138,
    "role_id": 9,
    "model": "assignment",
    "action": "read",
    "created_at": "2016-03-25T05:09:27.591Z",
    "updated_at": "2016-03-25T05:09:27.591Z"
  },
  {
    "id": 129,
    "role_id": 9,
    "model": "base_image",
    "action": "manage",
    "created_at": "2016-03-25T05:09:27.478Z",
    "updated_at": "2016-03-25T05:09:27.478Z"
  },
  {
    "id": 131,
    "role_id": 9,
    "model": "blueprint",
    "action": "manage",
    "created_at": "2016-03-25T05:09:27.503Z",
    "updated_at": "2016-03-25T05:09:27.503Z"
  },
  {
    "id": 128,
    "role_id": 9,
    "model": "cloud",
    "action": "manage",
    "created_at": "2016-03-25T05:09:27.467Z",
    "updated_at": "2016-03-25T05:09:27.467Z"
  },
  {
    "id": 136,
    "role_id": 9,
    "model": "deployment",
    "action": "manage",
    "created_at": "2016-03-25T05:09:27.567Z",
    "updated_at": "2016-03-25T05:09:27.567Z"
  },
  {
    "id": 133,
    "role_id": 9,
    "model": "environment",
    "action": "manage",
    "created_at": "2016-03-25T05:09:27.526Z",
    "updated_at": "2016-03-25T05:09:27.526Z"
  },
  {
    "id": 130,
    "role_id": 9,
    "model": "pattern",
    "action": "manage",
    "created_at": "2016-03-25T05:09:27.491Z",
    "updated_at": "2016-03-25T05:09:27.491Z"
  },
  {
    "id": 141,
    "role_id": 9,
    "model": "permission",
    "action": "create",
    "created_at": "2016-03-25T05:09:27.626Z",
    "updated_at": "2016-03-25T05:09:27.626Z"
  },
  {
    "id": 137,
    "role_id": 9,
    "model": "project",
    "action": "read",
    "created_at": "2016-03-25T05:09:27.579Z",
    "updated_at": "2016-03-25T05:09:27.579Z"
  },
  {
    "id": 140,
    "role_id": 9,
    "model": "role",
    "action": "read",
    "created_at": "2016-03-25T05:09:27.617Z",
    "updated_at": "2016-03-25T05:09:27.617Z"
  },
  {
    "id": 132,
    "role_id": 9,
    "model": "system",
    "action": "manage",
    "created_at": "2016-03-25T05:09:27.515Z",
    "updated_at": "2016-03-25T05:09:27.515Z"
  }
]
```

Error Response:

- Authentication failed: 401 Unauthorized
