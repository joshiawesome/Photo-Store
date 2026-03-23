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

const userProfilePopover = ref<InstanceType<typeof IconPopOver> | null>(null)

const onClick = (_id: string) => {
    userProfilePopover.value?.close()
}
</script>
