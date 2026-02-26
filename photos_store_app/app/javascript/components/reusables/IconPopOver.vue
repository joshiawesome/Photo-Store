<template>
    <div class="relative h-screen flex items-center justify-center">
        <div ref="reference" @click="open = !open">
            <slot name="trigger" />
        </div>

        <div v-if="open" ref="floating" :style="floatingStyles"
            class="bg-white shadow-lg p-4 rounded border border-gray-200">
            <slot name="content" />
        </div>
    </div>
</template>

<script setup lang="ts">
import { onBeforeUnmount, onMounted, ref, watchEffect } from "vue"
import { useFloating, autoUpdate, offset, flip, shift, Placement } from "@floating-ui/vue"

interface Props {
    placement: Placement
}

const { placement } = defineProps<Props>()

const open = ref(false)
const reference = ref<HTMLElement | null>(null)
const floating = ref<HTMLElement | null>(null)

const { update, floatingStyles } = useFloating(reference, floating, {
    placement,
    middleware: [offset(10), flip(), shift({ padding: 5 })],
    whileElementsMounted: autoUpdate,
})

const handleClickOutside = (event: MouseEvent) => {
    const target = event.target as Node;
    if (
        open.value &&
        reference.value &&
        floating.value &&
        !reference.value.contains(target) &&
        !floating.value.contains(target)
    ) {
        open.value = false;
    }
}

onMounted(() => {
    document.addEventListener("click", handleClickOutside)
})

onBeforeUnmount(() => {
    document.removeEventListener("click", handleClickOutside)
})

watchEffect(() => {
    if (open.value) update()
})
</script>

<style>
[v-cloak] {
    display: none
}
</style>