<template>
  <div>
    <NavBar />
    <div class="h-[calc(100vh-var(--navbar-height))]">
      <LoaderScreen v-show="isLoading" />
      <div v-show="!isLoading">
        <Products/>
      </div>
    </div>
    <Toast v-if="toastStore.toastConfig" v-bind="toastStore.toastConfig" />
  </div>
</template>

<script lang="ts" setup>
import { computed, onMounted } from 'vue'
import LoaderScreen from '@/components/reusables/LoaderScreen.vue'
import NavBar from '@/components/navbar/NavBar.vue'
import Products from './pages/Products.vue'
import Toast from '@/components/reusables/Toast.vue'
import { useAPI } from '@/hooks/useAPI'
import { useToastStore } from '@/stores/toastStore'

const toastStore = useToastStore()
const externalProductsAPI = useAPI<{}, {}>()

const hitAPIEndpoints = async () => {
  await externalProductsAPI.request({
    url: "/products/import",
    method: "POST"
  })
}

const isLoading = computed(() =>
  externalProductsAPI.loading.value
)

onMounted(() => {
  hitAPIEndpoints()
})
</script>
