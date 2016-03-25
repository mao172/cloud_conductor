
----

### [POST] /api/v1/tokens

Get Authentication Token.

#
### Parameters
* email String (required)
* password String (required)


#### Response

Correct Response: 201 Created

```javascript


{
  "auth_token": "jctcxJmagsNYskX3r1U_"
}
```

Error Response:

- Authentication failed: 401 Unauthorized
