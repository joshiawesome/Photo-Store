<template>
    <IconPopOver ref="userProfilePopover">
        <template #trigger>
            <div class="flex items-center gap-sm">
                <span class="text-white text-sm">{{ loginStore.loginConfig?.userName }}</span>
                <UserCircleIcon class="icon icon-xl text-white" />
            </div>
        </template>
        <template #content>
            <List :items="AVATAR_ITEMS" @click="onClick" />
        </template>
    </IconPopOver>
</template>

<script lang="ts" setup>
import { AVATAR_ITEMS } from '@/constants/avatarConstants'
import IconPopOver from '@/components/reusables/IconPopOver.vue'
import List from '@/components/reusables/List.vue'
import { ref } from 'vue'
import { UserCircleIcon } from '@heroicons/vue/24/solid'
import { useAPI } from '@/hooks/useAPI'
import { useLoginStore } from '@/stores/loginStore'
import { useToastStore } from '@/stores/toastStore'

const sessionAPI = useAPI<{message: string}, {}>()
const userProfilePopover = ref<InstanceType<typeof IconPopOver> | null>(null)
const loginStore = useLoginStore()

const onClick = async (id: string) => {
    if (id === 'logout') {
        const response = await sessionAPI.request({
            url: "/logout",
            method: "DELETE"
        })
    
        useToastStore().showtoast({
            message: response.message,
            type: "success"
        })

        // TO-DO: need to find a better way to update the CSRF token as logout destroys the session and existing CSRF token
        window.location.reload()
    }

    userProfilePopover.value?.close()
}
</script>
