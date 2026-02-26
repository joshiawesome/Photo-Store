<template>
    <div class="flex items-center justify-between w-full h-12.5 bg-navy-blue p-sm">
        <div></div>
        <div class="flex items-center gap-sm">
            <UserProfile />
            <Login />
            <SignUp />
        </div>
    </div>
</template>

<script lang="ts" setup>
import UserProfile from '@/components/navbar/UserProfile.vue'
import Login from '@/components/navbar/Login.vue'
import SignUp from '@/components/navbar/SignUp.vue'
</script>
