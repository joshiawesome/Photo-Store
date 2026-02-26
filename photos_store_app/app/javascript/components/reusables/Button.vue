<template>
    <div>
        <button @click="onClick" :class="`btn btn-${variant} btn-${size}`" :disabled="isDisabled">
            {{ label }}
        </button>
    </div>
</template>

<script lang="ts" setup>
interface Props {
    label: string
    onClick: () => void
    variant?: 'primary' | 'secondary'
    size?: 'sm' | 'md' | 'lg'
    isDisabled?: boolean
}

const { label, onClick, variant = 'primary', size = 'md', isDisabled = false } = defineProps<Props>()
</script>
