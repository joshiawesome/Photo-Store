<template>
    <IconPopOver ref="userProfilePopover">
        <template #trigger>
            <UserCircleIcon class="icon icon-xl text-white" />
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

const sessionAPI = useAPI<{}, {}>()
const userProfilePopover = ref<InstanceType<typeof IconPopOver> | null>(null)

const onClick = async (id: string) => {
    if (id === 'logout') {
        await sessionAPI.request({
            url: "/logout",
            method: "DELETE"
        })

        useLoginStore().loginConfig = null
    }

    userProfilePopover.value?.close()
}
</script>
