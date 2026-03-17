<template>
    <Teleport to="body">
        <div v-if="visible" :class="['absolute top-20 right-2 w-toast h-toast flex items-center justify-between p-sm rounded shadow-md', typeClass]">
            <div class="flex-1 text-sm">
                {{ message }}
            </div>

            <XMarkIcon class="icon icon-sm" @click="close" />
        </div>
    </Teleport>
</template>

<script lang="ts" setup>
import { ref, onMounted, computed } from 'vue'
import { XMarkIcon } from '@heroicons/vue/24/outline'

export interface IToastProps {
    message: string
    type?: 'success' | 'error' | 'info' | 'warning'
    duration?: number
}

const props = withDefaults(defineProps<IToastProps>(), {
    type: 'info',
    duration: 3000
})

const visible = ref(true)

const close = () => {
    visible.value = false
}

// auto close
onMounted(() => {
    if (props.duration > 0) {
        setTimeout(() => close(), props.duration)
    }
})

const typeClass = computed(() => {
    switch (props.type) {
        case 'success': return 'bg-green text-navy-blue text-sm'
        case 'error': return 'bg-red text-navy-blue text-sm'
        case 'warning': return 'bg-yellow text-navy-blue text-sm'
        case 'info': return 'bg-light-blue text-navy-blue text-sm'
        default: return 'bg-white text-navy-blue text-sm'
    }
})
</script>

<style scoped>
div {
    transition: opacity 0.3s ease;
}
</style>
