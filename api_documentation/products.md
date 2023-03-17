## Table of Content

---
- [Product Details](#product-details)
- [Product Buy](#product-buy)
- [Product Rent](#product-rent)

### Product Details

---
Returns product details.

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

### Product Buy

---
Returns response for buying product.

* **URL:** `{{Base_url}}/user/api/v1/products/:id/buy`

* **Method:** `POST`

* **Authorization:** `bearer-token`

*  **Params:** None

**Example**:

* **Success Response:**

* **Code:** 200 <br />
  **Content:**
```json
{
  "status_code": 200,
  "message": "Successfully bought"
}
```

* **Error Response:**
* **Code:** 404 <br />
  **Content:**
```json
{
  "error": "Product not available"
}
```
OR
* **Code:** 500 <br />
  **Content:**
```json
{
  "error": "Unable to buy product"
}
```

### Product Rent

---
Returns response for renting product.

* **URL:** `{{Base_url}}/user/api/v1/products/:id/rent`

* **Method:** `POST`

* **Authorization:** `bearer-token`

*  **Params:**

`from_date` string required, format: "YYYY-MM-DD"

`to_date` string required, format: "YYYY-MM-DD"

**Example**:
```json
{
    "from_date": "2023-03-16",
    "to_date": "2023-03-17"
}
```
* **Success Response:**

* **Code:** 200 <br />
  **Content:**
```json
{
  "status_code": 200,
  "message": "Successfully rented"
}
```

* **Error Response:**
* **Code:** 404 <br />
  **Content:**
```json
{
  "error": "Product not available"
}
```
OR
* **Code:** 500 <br />
  **Content:**
```json
{
  "error": "Unable to rent product"
}
```
