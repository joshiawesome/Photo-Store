<template>
  <div>
    <NavBar />
    <div class="h-[calc(100vh-var(--navbar-height))]">
      <LoaderScreen v-show="isLoading" />
      <div v-show="!isLoading">
        <Photos/>
      </div>
    </div>
    <Toast v-if="toastStore.toastConfig" v-bind="toastStore.toastConfig" />
  </div>
</template>

<script lang="ts" setup>
import { computed, onMounted } from 'vue'
import LoaderScreen from '@/components/reusables/LoaderScreen.vue'
import NavBar from '@/components/navbar/NavBar.vue'
import Photos from './pages/Photos.vue'
import Toast from '@/components/reusables/Toast.vue'
import { useAPI } from '@/hooks/useAPI'
import { useToastStore } from '@/stores/toastStore'

const toastStore = useToastStore()
const externalPhotosAPI = useAPI<{}, {}>()

const hitAPIEndpoints = async () => {
  await externalPhotosAPI.request({
    url: "/photos/import",
    method: "POST"
  })
}

const isLoading = computed(() =>
  externalPhotosAPI.loading.value
)

onMounted(() => {
  hitAPIEndpoints()
})
</script>
