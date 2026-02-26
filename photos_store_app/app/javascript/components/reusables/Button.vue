<template>
    <div>
        <button @click="onClick" :class="`btn btn-${variant} btn-${size}`">
            {{ label }}
        </button>
    </div>
</template>

<script lang="ts" setup>
enum Variant {
    Primary = 'primary',
    Secondary = 'secondary',
}

enum Size {
    Sm = 'sm',
    Md = 'md',
    Lg = 'lg',
}

interface Props {
    label: string
    onClick: () => void
    variant?: Variant
    size?: Size
}

const { label, onClick, variant = Variant.Primary, size = Size.Md } = defineProps<Props>()
</script>
