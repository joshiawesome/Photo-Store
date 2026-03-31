<template>
  <div>
    <NavBar :is-loading="isSessionLoading" />
    <div class="h-[calc(100vh-var(--navbar-height))]">
      <LoaderScreen v-show="isProductsLoading" />
      <div v-show="!isProductsLoading">
        <Products />
      </div>
    </div>
    <Toast v-if="toastStore.toastConfig" v-bind="toastStore.toastConfig" />
  </div>
</template>

<script lang="ts" setup>
import { computed, onMounted } from 'vue'
import { getUserNameFromEmail } from '@/utils/userUtils'
import LoaderScreen from '@/components/reusables/LoaderScreen.vue'
import NavBar from '@/components/navbar/NavBar.vue'
import Products from './pages/Products.vue'
import Toast from '@/components/reusables/Toast.vue'
import { useAPI } from '@/hooks/useAPI'
import { useToastStore } from '@/stores/toastStore'
import { useLoginStore } from '@/stores/loginStore'

const toastStore = useToastStore()
const loginStore = useLoginStore()

const externalProductsAPI = useAPI<{}, {}>()
const sessionAPI = useAPI<{ user: { email: string } }>()

const hitAPIEndpoints = async () => {
  await externalProductsAPI.request({
    url: "/products/import",
    method: "POST"
  })
}

const checkSession = async () => {
  try{
    const response = await sessionAPI.request({
      url: "/session",
      method: "GET"
    })

    if (response?.user) {
      loginStore.setLogin({
        isLoggedIn: true,
        userName: getUserNameFromEmail(response.user.email)
      })
    }
  } catch (error) {
    console.error('Session does not exist:', error)
  }
}

const isProductsLoading = computed(() => externalProductsAPI.loading.value)
const isSessionLoading = computed(() => sessionAPI.loading.value)

onMounted(() => {
  hitAPIEndpoints()
  checkSession()
})
</script>
