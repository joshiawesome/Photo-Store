<template>
    <IconPopOver>
        <template #trigger>
            <UserCircleIcon class="icon icon-xl text-white" />
        </template>
        <template #content>
            Content
        </template>
    </IconPopOver>
</template>

<script lang="ts" setup>
import { UserCircleIcon } from '@heroicons/vue/24/solid'
import IconPopOver from '@/components/reusables/IconPopOver.vue'
</script>
