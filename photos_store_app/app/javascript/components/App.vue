<template>
  <div>
    <NavBar />
    <div class="h-[calc(100vh-var(--navbar-height))]">
      <LoaderScreen v-if="isLoading" />
      <div v-else>
        Photos Loaded!
      </div>
    </div>
    <Toast v-if="toastStore.toastConfig" v-bind="toastStore.toastConfig" />
  </div>
</template>

<script lang="ts" setup>
import { computed, onMounted } from 'vue'
import { IPhotoConfig, usePhotosStore } from '@/stores/photosStore'
import LoaderScreen from '@/components/reusables/LoaderScreen.vue'
import NavBar from '@/components/navbar/NavBar.vue'
import Toast from '@/components/reusables/Toast.vue'
import { useAPI } from '@/hooks/useAPI'
import { useToastStore } from '@/stores/toastStore'

const toastStore = useToastStore()
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

const isLoading = computed(() =>
  externalPhotosAPI.loading.value ||
  internalPhotosAPI.loading.value
)

onMounted(() => {
  hitAPIEndpoints()
})


</script>
