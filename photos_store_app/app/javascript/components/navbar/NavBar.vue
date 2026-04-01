<template>
    <div class="flex items-center w-full h-navbar bg-navy-blue p-sm">
        <div class="flex-1"></div>

        <div class="w-full max-w-lg mr-sm">
            <Search />
        </div>

        <div v-if="!props.isLoading" class="flex-1 flex justify-end items-center gap-sm">
            <template v-if="loginStore.loginConfig">
                <UserProfile />
            </template>
            <template v-else>
                <Auth type="login" />
                <Auth type="signup" />
            </template>
        </div>
    </div>
</template>

<script lang="ts" setup>
import Auth from '@/components/navbar/Auth.vue'
import Search from '@/components/navbar/Search.vue'
import UserProfile from '@/components/navbar/UserProfile.vue'
import { useLoginStore } from '@/stores/loginStore'


interface Props {
  isLoading: boolean
}

const props = defineProps<Props>()

const loginStore = useLoginStore()
</script>
