<template>
  <div>
    <NavBar />
  </div>
</template>

<script lang="ts" setup>
import { importPhotos } from '@/services/photos/photos_api_service'
import NavBar from '@/components/navbar/NavBar.vue';
import { onMounted } from 'vue'


onMounted(() => {
  importPhotos()
})
</script>
