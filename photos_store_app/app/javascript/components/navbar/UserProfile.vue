<template>
    <IconPopOver placement="bottom">
        <template #trigger>
            <UserCircleIcon class="w-8 h-8 text-white cursor-pointer" />
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
