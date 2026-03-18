<template>
    <div class="relative">
        <button @click="onClick" :class="`btn btn-${variant} btn-${size}`" :disabled="isLoading || isDisabled">
            {{ label }}
        </button>
        <div class="absolute inset-0 flex items-center justify-center" v-if="isLoading">
            <Loader size="sm" />
        </div>
    </div>
</template>

<script lang="ts" setup>
import Loader from '@/components/reusables/Loader.vue'

interface Props {
    label: string
    onClick: () => void
    variant?: 'primary' | 'secondary'
    size?: 'sm' | 'md' | 'lg'
    isDisabled?: boolean
    isLoading?: boolean
}

const { label, onClick, variant = 'primary', size = 'md', isDisabled = false, isLoading = false } = defineProps<Props>()
</script>
