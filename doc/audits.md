
----

### [GET] /api/v1/audits

Get audit list.

#
### Parameters
- project_id: Project id


#### Response

Correct Response: 200 OK

```javascript


[
  {
    "id": 78,
    "ip": null,
    "account": 122,
    "status": 201,
    "request": "audit-3",
    "created_at": "2016-03-25T07:01:53.712Z",
    "updated_at": "2016-03-25T07:01:53.712Z",
    "project_id": 235
  }
]
```

Error Response:

- Authentication failed: 401 Unauthorized
