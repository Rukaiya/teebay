## Table of Content

---
- [Product Details](#product-details)

### Product Details

---
Returns response for product created by current user.

* **URL:** `{{Base_url}}/user/api/v1/products/:id`

* **Method:** `GET`

* **Authorization:** `bearer-token`

*  **Params:** None

**Example**:

* **Success Response:**

* **Code:** 200 <br />
  **Content:**
```json
{
  "id": 3,
  "title": "Oppo F19 Pro",
  "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna",
  "purchase_price": "29999.0",
  "rent_price": "50.0",
  "rent_charge_type": "hourly",
  "created_at": "2023-03-17T15:13:38.607Z"
}
```

* **Error Response:**
* **Code:** 404 <br />
  **Content:**
```json
{
  "error": "Not found"
}
```
OR
* **Code:** 500 <br />
  **Content:**
```json
{
  "error": "Unable to fetch product details"
}
```
