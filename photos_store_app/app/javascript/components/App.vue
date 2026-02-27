<template>
  <div>
    <NavBar />
  </div>
</template>

<script lang="ts" setup>
import { onMounted } from 'vue'
import NavBar from '@/components/navbar/NavBar.vue'
import { IPhotoConfig, usePhotosStore } from '@/stores/photosStore'
import { useAPI } from '@/hooks/usey'

const externalPhotosAPI = useAPI<{}, {}>()
const internalPhotosAPI = useAPI<IPhotoConfig[], {}>()

const hitAPIEndpoints = async () => {
  await externalPhotosAPI.request({
    url: "/photos/import",
    method: "POST"
  })

  const photos = await internalPhotosAPI.request({
    url: "/photos",
    method: "GET"
  })

  usePhotosStore().photos = photos
}

onMounted(() => {
  hitAPIEndpoints()
})
</script>
