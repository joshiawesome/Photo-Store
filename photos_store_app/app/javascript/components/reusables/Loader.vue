<template>
    <div :class="`loader loader-${size}`"></div>
</template>

<script lang="ts" setup>
interface Props {
    size?: 'xs' | 'sm' | 'md' | 'lg' | 'xl'
}

const props = withDefaults(defineProps<Props>(), {
    size: 'md'
})
</script>
