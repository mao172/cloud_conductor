
----

### [GET] /api/v1/assignments

Get assignment list.

#
### Parameters
- project_id: Project id
- account_id: Account id


#### Response

Correct Response: 200 OK

```javascript


[
  {
    "id": 311,
    "project_id": 175,
    "account_id": 451,
    "created_at": "2016-03-25T07:01:31.022Z",
    "updated_at": "2016-03-25T07:01:31.022Z"
  },
  {
    "id": 312,
    "project_id": 175,
    "account_id": 452,
    "created_at": "2016-03-25T07:01:31.096Z",
    "updated_at": "2016-03-25T07:01:31.096Z"
  }
]
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [GET] /api/v1/assignments/:id

Get specified assignment information.

#
### Parameters
- *id: Assignment id


#### Response

Correct Response: 200 OK

```javascript


{
  "id": 380,
  "project_id": 202,
  "account_id": 532,
  "created_at": "2016-03-25T07:01:41.621Z",
  "updated_at": "2016-03-25T07:01:41.621Z"
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [POST] /api/v1/assignments

Create assignment.

#
### Parameters
- *project_id: Project id
- *account_id: Account id


#### Response

Correct Response: 201 Created

```javascript


{
  "id": 395,
  "project_id": 208,
  "account_id": 552,
  "created_at": "2016-03-25T07:01:44.242Z",
  "updated_at": "2016-03-25T07:01:44.242Z"
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [DELETE] /api/v1/assignments/:id

Delete assignment.

#
### Parameters
- *id: Assignment id


#### Response

Correct Response: 204 No Content

```javascript

```

Error Response:

- Authentication failed: 401 Unauthorized
