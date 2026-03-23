<template>
    <div class="flex items-center justify-between w-full h-navbar bg-navy-blue p-sm">
        <div></div>
        <div class="h-full flex items-center gap-sm">
            <template v-if="loginStore.loginConfig">
                <UserProfile />
            </template>
            <template v-else>
                <Login />
                <SignUp />
            </template>
        </div>
    </div>
</template>

<script lang="ts" setup>
import Login from '@/components/navbar/Login.vue'
import SignUp from '@/components/navbar/SignUp.vue'
import UserProfile from '@/components/navbar/UserProfile.vue'
import { useLoginStore } from '@/stores/loginStore'

const loginStore = useLoginStore()
</script>
