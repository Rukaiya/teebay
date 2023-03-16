import { useEffect, useState } from 'react'
import './App.css'
import axios from 'axios'
import Products from './components/products'

const API_URL = "http://localhost:3000/user/api/v1/products"

function getAPIData() {
  return axios.get(API_URL).then((response) => response.data)
}

function App() {
  const [products, setProducts] = useState([]);
  useEffect(() => {
    let mounted = true;
    getAPIData().then((items) => {
      if (mounted) {
        console.log(items);
        setProducts(items);
      }
    });
    return () => (mounted = false);
  }, []);

  return (
    <div className="App">
      
      <Products products={products} />
      
    </div>
  )
}

export default App
