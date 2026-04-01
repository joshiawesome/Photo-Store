<template>
    <div class="relative h-full flex items-center justify-center">
        <div class="w-full" ref="reference" @click="isOpenOnClick ? open = !open : null">
            <slot name="trigger" />
        </div>

        <div v-if="open" ref="floating" :style="floatingStyles"
            class="w-full bg-white shadow-lg rounded border border-gray">
            <slot name="content" />
        </div>
    </div>
</template>

<script setup lang="ts">
import { onBeforeUnmount, onMounted, ref, watchEffect } from "vue"
import { useFloating, autoUpdate, offset, flip, shift, Placement } from "@floating-ui/vue"

interface Props {
    placement?: Placement
    isOpenOnClick?: boolean
}

const { placement = "bottom", isOpenOnClick = true } = defineProps<Props>()

const open = ref(false)
const reference = ref<HTMLElement | null>(null)
const floating = ref<HTMLElement | null>(null)


defineExpose({
  open: () => {if (!open.value) open.value = true },
  close: () => { if (open.value) open.value = false },
  toggle: () => { open.value = !open.value },
})

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