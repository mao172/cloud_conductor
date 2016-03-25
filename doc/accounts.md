
----

### [GET] /api/v1/accounts

Get account list.

#
### Parameters
* project_id Integer - Project id


#### Response

Correct Response: 200 OK

```javascript


[
  {
    "id": 11,
    "email": "30ded37c2e47b048@example.com",
    "name": "UserName",
    "admin": false,
    "created_at": "2016-03-25T07:00:26.392Z",
    "updated_at": "2016-03-25T07:00:26.392Z"
  },
  {
    "id": 12,
    "email": "38d93ff5a0602d2d@example.com",
    "name": "UserName",
    "admin": true,
    "created_at": "2016-03-25T07:00:26.407Z",
    "updated_at": "2016-03-25T07:00:26.407Z"
  },
  {
    "id": 13,
    "email": "monitoring@project_3.example.com",
    "name": "monitoring",
    "admin": false,
    "created_at": "2016-03-25T07:00:26.444Z",
    "updated_at": "2016-03-25T07:00:26.444Z"
  },
  {
    "id": 14,
    "email": "09193d2a336cd210@example.com",
    "name": "UserName",
    "admin": false,
    "created_at": "2016-03-25T07:00:26.641Z",
    "updated_at": "2016-03-25T07:00:26.641Z"
  },
  {
    "id": 15,
    "email": "650ec28cda7563e6@example.com",
    "name": "UserName",
    "admin": false,
    "created_at": "2016-03-25T07:00:26.711Z",
    "updated_at": "2016-03-25T07:00:26.711Z"
  }
]
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [GET] /api/v1/accounts/:id

Get specified account information.

#
### Parameters
* id Integer (required) - Account id


#### Response

Correct Response: 200 OK

```javascript


{
  "id": 75,
  "email": "cf311521875465d9@example.com",
  "name": "UserName",
  "admin": false,
  "created_at": "2016-03-25T07:00:31.765Z",
  "updated_at": "2016-03-25T07:00:31.765Z"
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [POST] /api/v1/accounts

Create account.

#
### Parameters
* email String (required) - Account email
* name String (required) - Account username
* password String (required) - Account password
* password_confirmation String (required) - Account password confirmation
* admin Integer - Account role


#### Response

Correct Response: 201 Created

```javascript


{
  "id": 93,
  "email": "8c31c12f543650ad@example.com",
  "name": "UserName",
  "admin": false,
  "created_at": "2016-03-25T07:00:33.510Z",
  "updated_at": "2016-03-25T07:00:33.510Z"
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [PUT] /api/v1/accounts/:id

Update account information.

#
### Parameters
* id Integer (required) - Account id
* email String - Account email
* name String - Account username
* password String - Account old password
* password_confirmation String - Account new password confirmation
* admin Integer - Account role


#### Response

Correct Response: 200 OK

```javascript


{
  "id": 115,
  "email": "new@example.com",
  "name": "new_name",
  "admin": false,
  "created_at": "2016-03-25T07:00:35.470Z",
  "updated_at": "2016-03-25T07:00:35.505Z"
}
```

Error Response:

- Authentication failed: 401 Unauthorized


----

### [DELETE] /api/v1/accounts/:id

Delete account.

#
### Parameters
* id Integer (required) - Account id


#### Response

Correct Response: 204 No Content

```javascript

```

Error Response:

- Authentication failed: 401 Unauthorized
