import React from 'react'

function Products(props) {
  return (
    <div>
      <h1>API Products</h1>
      {props.products.map((product) => {
        return (
        <div key={product.id}>
            <h2>{product.title}</h2>
        </div>
        );
      })}
    </div>
  );
}

export default Products;
