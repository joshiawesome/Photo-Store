<template>
  <div>
    <NavBar />
    <!-- <Photos /> -->
  </div>
</template>

<script lang="ts" setup>
import { importPhotos } from '@/services/photos/photos_api_service'
import NavBar from '@/components/NavBar.vue';
import { onMounted } from 'vue'
import Photos from '@/components/pages/Photos.vue';


onMounted(() => {
  importPhotos()
})
</script>
