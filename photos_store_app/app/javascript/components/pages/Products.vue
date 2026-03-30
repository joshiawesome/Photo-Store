<template>
    <div>
        <h2>Products</h2>
    </div>
</template>

<script lang="ts" setup>
import { onMounted } from 'vue';
import { Product } from '@/types/product.types';
import { useAPI } from '@/hooks/useAPI';

const productsAPI = useAPI<Product[], {}>()

const hitAPIEndpoints = async () => {
 const response =  await productsAPI.request({
    url: "/products",
    method: "GET"
  })
  
  console.log(response)
}

onMounted(()=>{
  hitAPIEndpoints()
})
</script>
