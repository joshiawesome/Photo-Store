<template>
    <div class="flex items-center justify-between w-full h-navbar bg-navy-blue p-sm">
        <div></div>
        <div class="flex items-center gap-sm">
            <Login />
            <SignUp />
            <UserProfile />
        </div>
    </div>
</template>

<script lang="ts" setup>
import Login from '@/components/navbar/Login.vue'
import SignUp from '@/components/navbar/SignUp.vue'
import UserProfile from '@/components/navbar/UserProfile.vue'
</script>
