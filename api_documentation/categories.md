## Table of Content

---
- [Category List](#category-list)

### Category List

---
Returns response for category list.

* **URL:** `{{Base_url}}/user/api/v1/categories`

* **Method:** `GET`

* **Authorization:** `bearer-token`

*  **Params:** None

**Example**:

* **Success Response:**

* **Code:** 200 <br />
  **Content:**
```json
[
  {
    "id": 1,
    "title": "ELECTRONICS"
  },
  {
    "id": 2,
    "title": "FURNITURE"
  }
]
```

* **Error Response:**
* **Code:** 500 <br />
  **Content:**
```json
{
  "error": "Unable to fetch categories"
}
```
