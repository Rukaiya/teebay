## Table of Content

---
- [User Registration](#user-registration)
- [User Login](#user-login)

### User Registration

---
Returns response for user registration.

  * **URL:** `{{Base_url}}/user/api/v1/users/signup`

* **Method:** `POST`

* **Authorization:** Optional

*  **Params:**

`first_name` string required

`last_name` string required

`email` string required

`phone` string required

`address` string required

`password` string required

`password_confirmation` string required

**Example**:
  ```json
{
  "email": "teebay_user@sazim.io",
  "password": "123456"
}
```

* **Success Response:**

* **Code:** 201 <br />
      **Content:**
```json
{
  "status_code": 201,
  "message": "Successfully created"
}
```

* **Error Response:**
* **Code:** 406 <br />
  **Content:**
```json
{
  "error": "Email already exists"
}
```
OR
```json
{
  "error": "Phone number already exists"
}
```
OR
```json
{
  "error": "Email already exists"
}
```
OR
```json
{
  "error": "Password cannot be blank"
}
```
OR
```json
{
  "error": "Password didn't match"
}
```

### User Login

---
Returns response for user login.

  * **URL:** `{{Base_url}}/user/api/v1/users/login`

* **Method:** `POST`

* **Authorization:** Optional

*  ** Params:**

`email` string required

`password` string required

**Example**:
  ```json
{
  "email": "teebay_user@sazim.io",
  "password": "123456"
}
```

* **Success Response:**

* **Code:** 200 <br />
      **Content:**
```json
{
  "token": "token",
  "expired_at": "2023-04-17T14:39:26.416Z"
}
```

* **Error Response:**
* **Code:** 401 <br />
  **Content:**
```json
{
  "error": "Unauthorized"
}
```

### User Logout

---
Returns response for user logout.

  * **URL:** `{{Base_url}}/user/api/v1/users/logout`

* **Method:** `DELETE`

* **Authorization:** `bearer-token`

*  **Params:** None

**Example**:

* **Success Response:**

* **Code:** 200 <br />
      **Content:**
```json
{
  "status_code": 200,
  "message": "Successfully logged out"
}
```

* **Error Response:**
* **Code:** 401 <br />
  **Content:**
```json
{
  "error": "Unauthorized"
}
```
