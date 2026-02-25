<template>
  <div>
    <Counter title="Counter" />
    <Photos />
  </div>
</template>

<script lang="ts" setup>
import Counter from '@/components/pages/Counter.vue'
import { importPhotos } from '@/services/photos/photos_api_service'
import { onMounted } from 'vue'
import Photos from '@/components/pages/Photos.vue';

onMounted(() => {
  importPhotos()
})
</script>
