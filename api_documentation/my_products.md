## Table of Content

---
- [My Product List](#my-product-list)
- [My Product Create](#my-product-create)
- [My Product Update](#my-product-update)

### My Product List

---
Returns my product list.

* **URL:** `{{Base_url}}/user/api/v1/my_products`

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
    "id": 2,
    "title": "iPhone 13 pro max",
    "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
    "purchase_price": "1500.0",
    "rent_price": "50.0",
    "rent_charge_type": "hourly",
    "created_at": "2023-03-15T23:47:16.217Z"
  }
]
```

* **Error Response:**
* **Code:** 500 <br />
  **Content:**
```json
{
  "error": "Unable to fetch user products"
}
```

### My Product Create

---
Returns response for my product create.

* **URL:** `{{Base_url}}/user/api/v1/my_products`

* **Method:** `POST`

* **Authorization:** `bearer-token`

*  **Params:**

`title` string required

`description` string required

`rent_charge_type` string required, values: `hourly` or `daily`

`purchase_price` float required

`rent_price` float required

`product_categories_attributes[category_id]` array required 

**Example**:
```json
{
  "title": "Oppo F19 Pro",
  "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna",
  "purchase_price": 29999,
  "rent_price": 50,
  "rent_charge_type": "hourly",
  "product_categories_attributes":[
    {
      "category_id": 1
    }
  ]
}
```
* **Success Response:**

* **Code:** 200 <br />
  **Content:**
```json
{
  "status_code": 201,
  "message": "Successfully created"
}
```

* **Error Response:**
* **Code:** 500 <br />
  **Content:**
```json
{
  "error": "Unable to create product"
}
```

### My Product Update

---
Returns response for my product update.

* **URL:** `{{Base_url}}/user/api/v1/my_products/:id`

* **Method:** `PUT`

* **Authorization:** `bearer-token`

*  **Params:**

`title` string required

`description` string required

`rent_charge_type` string required, values: `hourly` or `daily`

`purchase_price` float required

`rent_price` float required

**Example**:
```json
{
    "title": "Oppo F19 Pro",
    "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna",
    "purchase_price": 29999,
    "rent_price": 100,
    "rent_charge_type": "hourly"
}
```
* **Success Response:**

* **Code:** 200 <br />
  **Content:**
```json
{
  "status_code": 200,
  "message": "Successfully updated"
}
```

* **Error Response:**
* **Code:** 500 <br />
  **Content:**
```json
{
  "error": "Unable to update product"
}
```
