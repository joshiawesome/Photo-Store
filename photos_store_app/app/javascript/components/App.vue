<template>
  <div>
    <NavBar />
  </div>
</template>

<script lang="ts" setup>
import { onMounted } from 'vue'
import NavBar from '@/components/navbar/NavBar.vue'
import { IPhotoConfig, usePhotosStore } from '@/stores/photosStore'
import { useApi } from '@/hooks/useApi'

const externalPhotosApi = useApi<{}, {}>()
const internalPhotosApi = useApi<IPhotoConfig[], {}>()

const triggerApiCalls = async () => {
  await externalPhotosApi.request({
    url: "/photos/import",
    method: "POST"
  })

  const photos = await internalPhotosApi.request({
    url: "/photos",
    method: "GET"
  })

  usePhotosStore().photos = photos
}


onMounted(() => {
  triggerApiCalls()
})
</script>
