<template>
    <div>
        <h2>Photos</h2>
    </div>
</template>

<script lang="ts" setup>
import { onMounted } from 'vue';
import { Photo } from '@/types/product.types';
import { useAPI } from '@/hooks/useAPI';

const photosAPI = useAPI<Photo[], {}>()

const hitAPIEndpoints = async () => {
 const response =  await photosAPI.request({
    url: "/photos",
    method: "GET"
  })
  
  console.log(response)
}

onMounted(()=>{
  hitAPIEndpoints()
})
</script>
