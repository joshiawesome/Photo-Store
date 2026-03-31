<template>
    <Teleport to="body">
        <div v-if="visible" class="bg-white absolute top-20 right-2 w-toast h-toast rounded-b shadow-md">
            <div class="relative w-full h-full flex items-center justify-between p-sm rounded">
                <div :class="['absolute top-0 left-0 h-0.75 w-full', typeClass]" />
                <div class="flex-1 text-black text-sm">
                    {{ message }}
                </div>
                <XMarkIcon class="icon icon-sm" @click="close" />
            </div>
        </div>
    </Teleport>
</template>

<script lang="ts" setup>
import { ref, onMounted, computed } from 'vue'
import { useToastStore } from '@/stores/toastStore'
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
    useToastStore().toastConfig = null
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
        case 'success': return 'bg-green'
        case 'error': return 'bg-red'
        case 'warning': return 'bg-orange'
        case 'info': return 'bg-light-blue'
        default: return 'bg-white'
    }
})
</script>

<style scoped>
div {
    transition: opacity 0.3s ease;
}
</style>
