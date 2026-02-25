<template>
    <div>
        <h2>{{ title }}</h2>
        <p>This is a reference file to play around with pinia and vue</p>
        <button @click="increment">Count: {{ count }}</button>
        <p>Doubles: {{ doubled }}</p>
    </div>
</template>

<script lang="ts" setup>
import { useCounterStore } from '@/stores/counterStore'
import { storeToRefs } from 'pinia'
import { watch } from 'vue'

const props = defineProps({
    title: { type: String, required: true },
})

const counter = useCounterStore()
const { count, doubled } = storeToRefs(counter)
const { increment } = counter


watch(count, (newVal, oldVal) => {
    console.log('count changed')
})
</script>
