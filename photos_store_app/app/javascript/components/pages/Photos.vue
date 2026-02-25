<template>
    <div>
        <h2>Photos</h2>
        <p>Photos Count: {{ photos.length }}</p>
    </div>
</template>

<script lang="ts" setup>
import { usePhotosStore } from '@/stores/photosStore'
import { storeToRefs } from 'pinia'

const photosStore = usePhotosStore()
const { photos } = storeToRefs(photosStore)
</script>
